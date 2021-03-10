using Toybox.WatchUi as Ui;

class LocationController{

	var _model;
	var _running;
	
	function initialize () {
		_model = new $.LocationModel();
		_running = false;
	}
	
	function start() {
		_model.enablePositioning();
		_running = true;
	}
	
	function stop() {
		_model.disablePositioning();
		_running = false;
	}
	
	function getLocation(){
		if(_running){
			return _model.getLocationText();
		}else{
			return "Press Start for GPS";
		}
	}
	function onStartStop()	{
		if(_running){
			stop();			
		}else{
			start();
		}
		Ui.requestUpdate();
	}	
}