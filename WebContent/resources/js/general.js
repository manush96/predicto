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
	url = window.location.href;
	tmp = url.split('/');
	controller = $.trim(tmp[tmp.length-2]);
	module = $.trim(tmp[tmp.length-1]);
	$('a[href="'+controller+'/'+module+'"]').parents('.treeview').addClass("active");
	$('a[href="'+controller+'/'+module+'"]').parent().addClass("active_sidelink");
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