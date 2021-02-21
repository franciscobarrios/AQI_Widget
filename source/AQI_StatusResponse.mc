enum{
	SUCCESS = "success",
	CALL_LIMIT_REACH = "call_limit_reached",
	API_KEY_EXP = "api_key_expired",
	WRON_API_KEY = "incorrect_api_key",
	IP_LOCATION_FAILED = "ip_location_failed",
	NO_NEAREST_STATION = "no_nearest_station",
	FEATURE_NOT_AVAILABLE = "feature_not_available",
	TOO_MANY_REQUEST = "too_many_requests",
}
/*
success: returned when JSON file was generated successfully.
call_limit_reached: returned when minute/monthly limit is reached.
api_key_expired: returned when API key is expired.
incorrect_api_key: returned when using wrong API key.
ip_location_failed: returned when service is unable to locate IP address of request.
no_nearest_station: returned when there is no nearest station within specified radius.
feature_not_available: returned when call requests a feature that is not available in chosen subscription plan.
too_many_requests: returned when more than 10 calls per second are made.
*/