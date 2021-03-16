class LocationModel{

	var _lat;
	var _long;
	var _accuracy;
	var _locationText;
	
	function initialize () {
		_locationText = "Waiting for GPS";
	}
	
	function enablePositioning() {
		Position.enableLocationEvents(Position.LOCATION_CONTINUOUS, self.method(:onPosition));
	}
	
	function disablePositioning() {
		Position.enableLocationEvents(Position.LOCATION_DISABLE, self.method(:onPosition));
	}
	
	function onPosition(info) {	
		_lat = info.position.toDegrees()[0];
		_long = info.position.toDegrees()[1];
		_accuracy = info.accuracy;
		var accuracyText = "";
		
		 if (info.accuracy == Position.QUALITY_GOOD) {
		 	accuracyText = "GPS quality: good.";
		 } else if (info.accuracy == Position.QUALITY_USABLE) {
		 	accuracyText = "GPS quality: usable.";
		 } else if (info.accuracy == Position.QUALITY_POOR) {
		 	accuracyText = "GPS quality: poor.";
		 } else if (info.accuracy == Position.QUALITY_LAST_KNOWN) {
		 	accuracyText = "GPS quality: last known";
		 } else if (info.accuracy == Position.QUALITY_NOT_AVAILABLE) {
		 	accuracyText = "GPS quality: not available.";
		 }
		
		_locationText = _lat.toString() + ",\n" + _long.toString() + "\n" + accuracyText;
	}
	
	function getLocationText() {
		return _locationText;
	}	
}