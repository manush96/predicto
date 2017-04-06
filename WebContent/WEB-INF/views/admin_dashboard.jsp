<%@include file="adminHeader.jsp" %>      
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<script src="resources/js/jquery.js"></script>
<div class="w3-sidebar w3-bar-block w3-black w3-card-2" style="width:130px">
  <h5 class="w3-bar-item">Menu</h5>
  <button class="w3-bar-item  w3-button tablink" onclick="openLink(event, 'Fade')">Linear regression</button>
  <button class="w3-bar-item  w3-button tablink" onclick="openLink(event, 'Fade1')">Push Daily notifications</button>
  <button class="w3-bar-item  w3-button tablink" onclick="openLink(event, 'Fade2')">Push weekly notifications</button>
  <button class="w3-bar-item  w3-button tablink" onclick="openLink(event, 'Fade3')">Push food notifs</button>
  
</div>

<div style="margin-left:330px">
  <div class="w3-padding">Hello Admin!</div>

  <div id="Fade" class="w3-container city w3-animate-opacity" style="display:none">
    <h2>Linear regression</h2>
    <p><a href="">Click here to train algorithm</a></p>
    </div>
    
  <div id="Fade1" class="w3-container city w3-animate-opacity" style="display:none">
    <h2>Push Daily notifications</h2>
    <p><a href="admin/push_daily">Click here to Push Daily notifications</a></p>
    </div>
    
  <div id="Fade2" class="w3-container city w3-animate-opacity" style="display:none">
    <h2>Push Weekly notifications</h2>
    <p><a href="admin/push_weekly">Click here to Push Weekly notifications</a></p>
    </div>
  <div id="Fade3" class="w3-container city w3-animate-opacity" style="display:none">
    <h2>Push food notifications</h2>
    <p><a href="admin/push_food">Click here to Push food notifications</a></p>
    </div>
    
</div>
<script>
function openLink(evt, animName) {
  var i, x, tablinks;
  x = document.getElementsByClassName("city");
  for (i = 0; i < x.length; i++) {
     x[i].style.display = "none";
  }
  tablinks = document.getElementsByClassName("tablink");
  for (i = 0; i < x.length; i++) {
     tablinks[i].className = tablinks[i].className.replace("w3-red", "");
  }
  document.getElementById(animName).style.display = "block";
  evt.currentTarget.className += " w3-red";
}
$(document).ready(function(){
	$("#button1").on('click',function(){
		$.ajax
		({
			type: "POST",
			url: "user/admin_get_user",
			success: function(response)
			{
				if($("#table1").is(':empty'))
			    {
				$("#table1").append(response);
			    }
			}
		});

	});
	$("#facto").on('click',function(){
		var valo=$(".fact").val();
		$.ajax
		({
			type: "POST",
			url: "user/admin_add_fact",
			data: {"fact":valo},
			success: function(response)
			{
				$(".added").append("Fact added")
			}
		});
	});
	$("#quot").on('click',function(){
		var valo=$(".quote").val();
		$.ajax
		({
			type: "POST",
			url: "user/admin_add_quote",
			data: {"quote":valo},
			success: function(response)
			{
				$(".added").append("quote added")
			}
		});
	});
	$("#get_analysis").on('click',function(){
		$.ajax
		({
			type:'POST',
			url:"user/admin_get_analysis",
			success:function(response)
			{
				if($("#timers").is(':empty'))
			    {
				$("#timers").append(response);
			    }
			}
		});
	});
});
</script>

</body>
</html>