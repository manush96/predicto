<%@include file="adminHeader.jsp" %>      
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<script src="resources/js/jquery.js"></script>
<div class="w3-sidebar w3-bar-block w3-black w3-card-2" style="width:130px">
  <h5 class="w3-bar-item">Menu</h5>
  <button class="w3-bar-item  w3-button tablink" onclick="openLink(event, 'Fade')">Linear regression</button>
  <button class="w3-bar-item  w3-button tablink" onclick="openLink(event, 'Fade12')">Linear regression(Algo)</button>
  <button class="w3-bar-item  w3-button tablink" onclick="openLink(event, 'Fade13')">Neural network</button>

  <button class="w3-bar-item  w3-button tablink" onclick="openLink(event, 'Fade1')">Push Daily notifications</button>
  <button class="w3-bar-item  w3-button tablink" onclick="openLink(event, 'Fade2')">Push weekly notifications</button>
  <button class="w3-bar-item  w3-button tablink" onclick="openLink(event, 'Fade3')">Push food notifs</button>
  
</div>

<div style="margin-left:330px">
  <div id="Fade" class="w3-container city w3-animate-opacity" style="display:none">
    <h2>Linear regression</h2>
    <p><a href="javascript:foo('train',this)">
		<button type="button" class="btn btn-primary">
	    	<span class="glyphicon glyphicon-wrench"></span> Train Algorithm
	    </button>
	</a></p>
    <br>
    <p><a href="javascript:foo('test',this)">
    	<button type="button" class="btn btn-success">
			<span class="glyphicon glyphicon-check"></span> Test Algorithm
		</button>
    </a></p>
   <br>
  
    <div class="dis"></div>
    </div>
  <div id="Fade12" class="w3-container city w3-animate-opacity" style="display:none">
    <h2>Linear regression using Normal equation algorithm</h2><br/>
    <p><a href="javascript:foo1('train',this)">
	    <button type="button" class="btn btn-primary">
	    	<span class="glyphicon glyphicon-wrench"></span> Train Algorithm
	    </button>
    </a></p>
    <br>
    <p><a href="javascript:foo1('test',this)">
		<button type="button" class="btn btn-success">
			<span class="glyphicon glyphicon-check"></span> Test Algorithm
		</button>
	</a></p>
   <br>
  
    <div class="dis"></div>
    </div>
    <div id="Fade13" class="w3-container city w3-animate-opacity" style="display:none">
    <h2>Neural network</h2>
    <p><a href="javascript:foo2('train',this)">
		<button type="button" class="btn btn-primary">
	    	<span class="glyphicon glyphicon-wrench"></span> Train Algorithm
	    </button>
	</a></p>
    <br>
    <p><a href="javascript:foo2('test',this)">
    	<button type="button" class="btn btn-success">
			<span class="glyphicon glyphicon-check"></span> Test Algorithm
		</button>
    </a></p>
   <br>
  
    <div class="dis"></div>
    </div>   
     
  <div id="Fade1" class="w3-container city w3-animate-opacity" style="display:none">
    <h2>Push Daily notifications</h2>
    <p><a href="admin/push_daily">
    	<button type="button" class="btn btn-primary">
			<span class="glyphicon glyphicon-check"></span> Push Daily notifications
		</button>
    </a></p>
    </div>
    
  <div id="Fade2" class="w3-container city w3-animate-opacity" style="display:none">
    <h2>Push Weekly notifications</h2>
    <p><a href="admin/push_weekly">
		<button type="button" class="btn btn-primary">
			<span class="glyphicon glyphicon-check"></span> Push Weekly notifications
		</button>
	</a></p>
    </div>
  <div id="Fade3" class="w3-container city w3-animate-opacity" style="display:none">
    <h2>Push food notifications</h2>
    <p><a href="admin/push_food">
    	<button type="button" class="btn btn-primary">
			<span class="glyphicon glyphicon-check"></span> Push Food notifications
		</button>
    </a></p>
    </div>
    
</div>
<script>
function foo(t,e)
{
	if(t=='train')
	{
		$.ajax
		({
			type: "POST",
			url: "admin/train_linear_weka",
			success: function(response)
			{
				$(".dis").empty();
				$(".dis").append(response);
			}
		});
	}
	else if(t=='test')
	{
		$.ajax
		({
			type: "POST",
			url: "admin/test_linear_weka",
			success: function(response)
			{
				$(".dis").empty();
				$(".dis").append(response);
			}
		});
	}
	$("#"+e.id).find(".btn").addClass("disabled");
}
function foo1(t,e)
{
	if(t=='train')
	{
		$.ajax
		({
			type: "POST",
			url: "admin/train_linear_algo",
			success: function(response)
			{
				$(".dis").empty();
				$(".dis").append(response);
			}
		});
	}
	else if(t=='test')
	{
		$.ajax
		({
			type: "POST",
			url: "admin/test_linear_algo",
			success: function(response)
			{
				$(".dis").empty();
				$(".dis").append(response);
			}
		});
	}
	$("#"+e.id).find(".btn").addClass("disabled");
}
function foo2(t,e)
{
	if(t=='train')
	{
		$.ajax
		({
			type: "POST",
			url: "admin/train_neural",
			success: function(response)
			{
				$(".dis").empty();
				$(".dis").append(response);
			}
		});
	}
	else if(t=='test')
	{
		$.ajax
		({
			type: "POST",
			url: "admin/test_neural",
			success: function(response)
			{
				$(".dis").empty();
				$(".dis").append(response);
			}
		});
	}
	$("#"+e.id).find(".btn").addClass("disabled");
}
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
  $(".dis").empty();
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