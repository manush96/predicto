var lat, lng, hr;
var return_url = "user/dashboard";
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
	$('[data-toggle="tooltip"]').tooltip(); 
	url = window.location.href;
	url = url.split("?")[0];
	tmp = url.split('/');
	controller = $.trim(tmp[tmp.length-2]);
	module = $.trim(tmp[tmp.length-1]);
	$('a[href="'+controller+'/'+module+'"]').parents('.treeview').addClass("active");
	$('a[href="'+controller+'/'+module+'"]').parent().addClass("active_sidelink");
	return_url = controller+'/'+module;
	$(document).on("click",".confirm_friend", function(e)
	{
		e.stopPropagation();
		var rel = $(this).attr('rel');
		var par = $(this).parents(".confirm_friend_li");
		$.ajax
		({
			type: "POST",
			url: "friend/confirm_friend",
			data: { id:rel },
			success: function(response)
			{
				par.html('<h4 class="text-center text-success">Confirmed Friend <span class="glyphicon glyphicon-ok"></span></h4>');
			}
		});
	});
	$(document).on("click",".decline_friend", function(e)
	{
		e.stopPropagation();
		var rel = $(this).attr('rel');
		var par = $(this).parents(".confirm_friend_li");
		$.ajax
		({
			type: "POST",
			url: "friend/decline_friend",
			data: { id:rel },
			success: function(response)
			{
				par.html('<h4 class="text-center text-danger">Declined Friend <span class="glyphicon glyphicon-remove"></span></h4>');
			}
		});
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
function edit_profile()
{
	$.confirm({
		title: '<h4 class="text-center">Update Profile</h4>',
		columnClass: 'col-sm-offset-2 col-sm-10',
		backgroundDismiss: true,
		type: 'blue',
		content: '<form id="profile_form" action="user/update_profile" method="POST"><div class="col-sm-2"><h4>Weight: </h4></div><div class="col-sm-6"><input type="number" name="weight" id="weight" class="form-control" placeholder="Your weight (in kgs)" required value="'+weight+'"/></div><div class="clearfix"></div><br/><div class="col-sm-2"><h4>Height: </h4></div><div class="col-sm-6"><input type="number" name="height" id="height" class="form-control" placeholder="Your height (in cms)" required value="'+height+'"/></div><div class="clearfix"></div><br/><div class="col-sm-2"><h4>Age: </h4></div><div class="col-sm-6"><input type="number" name="age" id="age" class="form-control" placeholder="How old are you? (Eg 27 years)" required value="'+age+'"/></div><div class="clearfix"></div><br/><input type="hidden" name="return_url" value="'+return_url+'"/></form>',
		theme: 'material',
		closeIcon: true,
		buttons: {
	        formSubmit: {
	            text: 'Submit',
	            btnClass: 'btn-blue',
	            action: function () {
	            	var age = this.$content.find('#age').val();
	                var weight = this.$content.find('#weight').val();
	                var height = this.$content.find('#height').val();
	                if(age == "" || height == "" || weight == "")
	                {
	                	$.alert('No fields can be empty');
	                    return false;
	                }
	                $("#profile_form").submit();
	            }
	        },
	        cancel: function () {
	            //close
	        },
	    }
	});
}
function change_password()
{
	$.confirm({
		title: '<h4 class="text-center">Change Password</h4>',
		columnClass: 'col-sm-offset-2 col-sm-10',
		backgroundDismiss: true,
		type: 'dark',
		content: '<form id="pass_form" action="user/change_password" method="POST"><input type="password" name="cur_p" id="cur_p" class="form-control" placeholder="Current password" required/><br/><input type="password" name="new_p_1" id="new_p_1" class="form-control" placeholder="New password" required/><br/><input type="password" name="new_p_2" id="new_p_2" class="form-control" placeholder="Repeat new password" required/><input type="hidden" name="return_url" value="'+return_url+'"/></form>',
		theme: 'material',
		closeIcon: true,
		buttons: {
	        formSubmit: {
	            text: 'Submit',
	            btnClass: 'btn-blue',
	            action: function () {
	            	var cur_p = this.$content.find('#cur_p').val();
	                var new_p_1 = this.$content.find('#new_p_1').val();
	                var new_p_2 = this.$content.find('#new_p_2').val();
	                if(cur_p == "" || new_p_1 == "" || new_p_2 == "")
	                {
	                	$.alert('No fields can be empty');
	                    return false;
	                }
	                if(new_p_1 != new_p_2){
	                    $.alert('Passwords do not match');
	                    return false;
	                }
	                $("#pass_form").submit();
	            }
	        },
	        cancel: function () {
	            //close
	        },
	    }
	});
}