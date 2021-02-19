using Toybox.Application;
using Toybox.WatchUi;
using Toybox.WatchUi as Ui;
using Toybox.Position;
using Toybox.System;

const URL_BASE = "https://api.airvisual.com/v2/nearest_city?";
const KEY = "de4e9f34-2b3e-4c25-b120-f8f7aee8c81d";

class AQI_WidgetApp extends Application.AppBase {

	hidden var _lat;
  	hidden var _lon;

    function initialize() {AppBase.initialize();}

    // onStart() is called on application start up
    function onStart(state) {
    	Position.enableLocationEvents(Position.LOCATION_ONE_SHOT,method(: onPosition));
    	makeRequest(_lat, _lon);
    	onPosition();
    }

    // onStop() is called when your application is exiting
    function onStop(state) {
    }

    // Return the initial view of your application here
    function getInitialView() {
        return [ new AQI_WidgetView("","","","","") ];
    }

	function onReceive(responseCode, data) {
	// System.println(data);
	    if (responseCode == 200) {
	      var jsonInfo = data;
	      var jsonData = jsonInfo.get("data");

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
	          new AQI_WidgetView(temp, hum, aqiUs, aqiColor, city),
	          null, Ui.SLIDE_IMMEDIATE);
	    }
	}

    function setAqiColor(aqi) {
	    var color;
	    if (aqi >= 0 && aqi <= 50) {
	      color = "green";
	    } else if (aqi > 50 && aqi < 100) {
	      color = "yellow";
	    } else if (aqi > 100 && aqi < 150) {
	      color = "orange";
	    } else if (aqi > 150 && aqi < 200) {
	      color = "red";
	    } else if (aqi > 200 && aqi < 250) {
	      color = "purple";
	    } else {
	      color = "dark_red";
	    }
	    return color;
  	}

    function makeRequest(lat, lon) {
    // Villarrica  -39.21703484861341, -72.24387544507489
    // var url= URL_BASE + "lat=-39.21703484861341&lon=-72.24387544507489" + "&key=" + KEY;

    // Reykjavík 64.18513020159337, -21.728636234635115
    // var url= URL_BASE + "lat=64.18513020159337&lon=-21.728636234635115" + "&key=" + KEY;

    // Mumbai 19.117931689682074, 72.89133494744027
    // var url= URL_BASE + "lat=19.117931689682074&lon=72.89133494744027" + "&key=" + KEY;

    var url = URL_BASE + "lat=" + lat + "&lon=" + lon + "&key=" + KEY;
    var params = null;
    var options = {
			:method       => Communications.HTTP_REQUEST_METHOD_GET,
         	:responseType => Communications.HTTP_RESPONSE_CONTENT_TYPE_JSON
    	};
    var responseCallback = method( : onReceive);
    Communications.makeWebRequest(url, params, options, method( : onReceive));
  }

  function onPosition() {
    var location = Position.getInfo().position.toDegrees();
    var lat = location[0];
    var lon = location[1];
  }
}