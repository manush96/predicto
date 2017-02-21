var lat, lng, hr;
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
	    	    set_lat_long();
	    	}, "jsonp");
	    }
	});
});
function showPosition(position) {
	lat = position.coords.latitude;
	lng = position.coords.longitude;
	set_lat_long();
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
			window.location.href = hr;
		},
		error: function(response)
		{
			return false;
		}
	});
}