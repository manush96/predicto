$(document).ready(function()
{
	$("#search_friends").click(function()
	{
		var q = $("#user_search").val();
		$.ajax
		({
			type: "POST",
			url: "friend/get_friends",
			data: { q:q },
			success: function(response)
			{
				$("#friend_div").html(response);
			}
		});
	});
	$(document).on("click",".add_friend",function()
	{
		var rel = $(this).attr('rel');
		var par = $(this).parents("td");
		var tr = $(this).parents("tr");
		$.ajax
		({
			type: "POST",
			url: "friend/add_friend",
			data: { id:rel },
			success: function(response)
			{
				par.html('<h4>Request Sent <span class="glyphicon glyphicon-ok"></span></h4>');
				setTimeout(function()
				{
					tr.fadeOut("slow");
				},2000);
			}
		});
	});
});