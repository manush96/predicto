<%@page import="java.io.File"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.predicto.model.Daily_data" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@include file="header.jsp" %>
<%@include file="sidebar.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="resources/css/morris.css"/>
<link href="resources/css/main.css" rel="stylesheet"/>
<script src="resources/js/morris.js"></script>
<script src="resources/js/raphael.js"></script>
<div class="col-sm-offset-2 col-sm-7">
<form action="user/set_goal_save">
Calories burnt per day
<input data-slider-id="blue" data-slider-value="${burn_goal}" name="burn" type="text" class="slider form-control" data-slider-min="0" data-slider-max="4000" data-slider-step="20" data-slider-handle="round" />
Calories intake per day
<input data-slider-id="blue" data-slider-value="${intake_goal }" name="intake" type="text" class="slider form-control" data-slider-min="0" data-slider-max="2000" data-slider-step="10" data-slider-handle="round" />
<div class="col-sm-offset-5">
<br>
<br>
<script>
   $(document).ready(function () {
 	    $('.slider').slider();
   });
</script>
<input type="submit" class="btn btn-danger" value="Set Goals">
</div>
</form>
</div>
