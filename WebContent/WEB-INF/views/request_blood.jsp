<%@page import="java.io.File"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@include file="header.jsp" %>
<%@include file="sidebar.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="resources/css/morris.css"/>
<link href="resources/css/main.css" rel="stylesheet"/>
<div class="col-sm-6 col-sm-offset-3 forme">
<form action="user/send_blood_req" method="post">
Enter the type of blood required:
<br>
<select name="typ" class="form-control" id="typ">
	<option value="AP">A+</option>
	<option value="AM">A-</option>
	<option value="BP">B+</option>
	<option value="BM">B-</option>
	<option value="ABP">AB+</option>
	<option value="ABM">AB-</option>
	<option value="OP">O+</option>
	<option value="OM">O-</option>
</select>
<br>

Enter the phone number for contact:
<input type="text" class="form-control" id="phone">
<br>
<button type="button" class="subm form-control btn btn-primary" >Submit request</button>

</form>
</div>
<div class="resp col-sm-6 col-sm-offset-3">


</div>
<script>
$(document).ready(function(){
	$(".subm").on('click',function(){
		var typ=$("#typ").val();
		var cont=$("#phone").val();
		
		$.ajax
		({
			type: "GET",
			url: "user/send_blood_req?typer="+typ+"&cont="+cont,
			success: function(response)
			{
				$(".forme").empty();
				$(".resp").append("<h2>Request successfully submitted. You will be notified when we have a match.</h2>");
			}
		});

	});
});




</script>
</body>
</html>