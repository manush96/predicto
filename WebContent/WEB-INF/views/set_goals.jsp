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
	<div class="box box-primary">
		<div class="box-header with-border">
			<div class="box-title">
				Set your goals
			</div>
		</div>
		<div class="box-body">
			<form action="user/set_goal_save">
				Calories burnt per day
				<input data-slider-id="blue" data-slider-value="${burn_goal}" name="burn" type="text" class="slider form-control" data-slider-min="500" data-slider-max="3000" data-slider-step="50" data-slider-handle="round" />
				Calories intake per day
				<input data-slider-id="red" data-slider-value="${intake_goal }" name="intake" type="text" class="slider form-control" data-slider-min="500" data-slider-max="3000" data-slider-step="50" data-slider-handle="round" />
				<div class="clearfix"></div><br/>
				<div class="col-sm-offset-5">
					<input type="submit" class="btn btn-success" value="Set Goals">
				</div>
			</form>
		</div>
	</div>
</div>
<script>
   $(document).ready(function () {
 	    $('.slider').slider();
   });
</script>
