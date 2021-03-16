using Toybox.Application;
using Toybox.WatchUi;
using Toybox.WatchUi as Ui;
using Toybox.Position;
using Toybox.System;
using GpsBarrel as Gps;

const URL_BASE = "https://api.airvisual.com/v2/nearest_city?";

class AQI_WidgetApp extends Application.AppBase {

	hidden var _lat;
  	hidden var _lon;
	hidden var _dictionaryData = {
					"aqi" 	=> "",
					"temp" 	=> "",
					"hum" 	=> "",
					"color"	=> "",
					"min"	=> "",
					"max"	=> "",
				};

    function initialize() {
    	AppBase.initialize();
    	Gps.gpsMode("CONTINUOUS");
    	Gps.start();
    }

	
    function onStart(state) {
    
    	var location = Gps.getLocation();
    	System.println(location);
    
    	//makeRequest(latitude, longitude);
    
		
    }

    function onStop(state) {
    
    }

    function getInitialView() {
        return [ new AQI_WidgetView("","","","","") ];
    }

	function onReceive(responseCode, data) {
	
	System.println(data);
		if (responseCode == 200) {
			var jsonResponse = data;
	    	var status = jsonResponse.get("status");

	    	if(status.equals($.SUCCESS)){
			    var jsonData = jsonResponse.get("data");
				var jsonCity = jsonData.get("city");
				var jsonState = jsonData.get("state");
				var city = jsonCity + ",\n " + jsonState;
				var jsonCurrent = jsonData.get("current");
				var jsonPollution = jsonCurrent.get("pollution");
				var aqiUs = jsonPollution.get("aqius");
				var jsonWeather = jsonCurrent.get("weather");
				var temp = jsonWeather.get("tp");
				var hum = jsonWeather.get("hu");
				var aqiColor = setAqiColor(aqiUs.toNumber());
				Ui.switchToView(
		    		new AQI_WidgetView(temp, hum, aqiUs, aqiColor, city),null,Ui.SLIDE_IMMEDIATE);
			}else{
				Ui.switchToView(new AQI_ErrorView(), null, Ui.SLIDE_BLINK);
			}
		}else{
	    	Ui.switchToView(new AQI_ErrorView(), null, Ui.SLIDE_BLINK);
	    }
	}

    function setAqiColor(aqi) {
	    var color;
	    if (aqi >= 0 && aqi <= 50) {
	      color = $.GREEN;
	    } else if (aqi > 50 && aqi < 100) {
	      color = $.YELLOW;
	    } else if (aqi > 100 && aqi < 150) {
	      color = $.ORANGE;
	    } else if (aqi > 150 && aqi < 200) {
	      color = $.RED;
	    } else if (aqi > 200 && aqi < 250) {
	      color = $.PURPLE;
	    } else {
	      color = $.DARK_RED;
	    }
	    return color;
  	}

    function makeRequest(lat, lon) {
	    // Villarrica  -39.21703484861341, -72.24387544507489
	    // var url= URL_BASE + "lat=-39.21703484861341&lon=-72.24387544507489" + "&key=" + $.API_KEY;
	
	    // Reykjavík 64.18513020159337, -21.728636234635115
	     //var url= URL_BASE + "lat=64.18513020159337&lon=-21.728636234635115" + "&key=" + $.API_KEY;
	
	    // Mumbai 19.117931689682074, 72.89133494744027
	    // var url= URL_BASE + "lat=19.117931689682074&lon=72.89133494744027" + "&key=" + $.API_KEY;
	
	    var url = URL_BASE + "lat=" + lat + "&lon=" + lon + "&key=" + $.API_KEY;
	    var params = null;
	    var options = {
			:method       => Communications.HTTP_REQUEST_METHOD_GET,
         	:responseType => Communications.HTTP_RESPONSE_CONTENT_TYPE_JSON
    	};
    	var responseCallback = method(:onReceive);
    	Communications.makeWebRequest(url, params, options, method(:onReceive));
	}
}