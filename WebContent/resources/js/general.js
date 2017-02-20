var lat, lng;
$(document).ready(function()
{
	$("#location_link").click(function(e)
	{
		hr = $(this).attr('href');
		e.preventDefault();
		
		if (navigator.geolocation) {
	        navigator.geolocation.getCurrentPosition(showPosition);
	    } else {
	    	$.get("http://ipinfo.io", function(response) {
	    	    loc = response.loc.split(",");
	    	    lat = loc[0];
	    	    lng = loc[1];
	    	    return set_lat_long();
	    	}, "jsonp");
	    }
		window.location.href = hr;
	});
});
function showPosition(position) {
	lat = position.coords.latitude;
	lng = position.coords.longitude;
	return set_lat_long();
}
function set_lat_long()
{
	$.ajax
	({
		type: "GET",
		url: "stores/set_lat_long",
		data: { lat: lat, lng: lng },
		success: function(response)
		{
			return true;
		},
		error: function(response)
		{
			return false;
		}
	});
}