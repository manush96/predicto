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
<div class="col-md-offset-1 col-md-10">
	<div class="col-sm-12">
		<div class="box box-primary">
			<div class="box-header with-border">
				<div class="box-title">
					Set your goals
				</div>
			</div>
			<div class="box-body">
				<div class="col-md-10 col-md-offset-1">
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
	</div>
	<div class="clearfix"></div>
	<div class="col-md-12">
		<div class="box box-warning">
			<div class="box-header with-border text-center">
				<h3 class="box-title">
					What should be my "<b>Calorie Burn</b>" goal?
				</h3>
			</div>
			<div class="box-body">
				<ul class="list-group">
					<li class="list-group-item">
						<p><span class="glyphicon glyphicon-paperclip"></span> &nbsp;&nbsp;<b>One pound</b> of fat equals <b>3,500 calories</b>, which means, to lose 1 to 2 pounds per week, you need to burn off <b>500 to 1,000 calories more per day</b> than you <b>consume</b>.</p>
					</li>
				</ul>
			</div>
		</div>
	</div>
	<div class="col-md-12">
		<div class="box box-danger">
			<div class="box-header with-border text-center">
				<h3 class="box-title">
					What is the ideal daily "<b>Calorie Intake</b>" per day?
				</h3>
			</div>
			<div class="box-body">
				<table class="table table-striped table-bordered table-hover table-responsive">
					<thead>
						<tr>
							<th>Gender</th>
							<th>Age</th>
							<th>Inactive</th>
							<th>Moderately active</th>
							<th>Active</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>Child</td>
							<td>2-3</td>
							<td>1,000</td>
							<td>1,000-1,400</td>
							<td>1,000-1,400</td>
						</tr>
						<tr>
							<td rowspan="6" style="vertical-align: middle">Female</td>
							<td>4-8</td>
							<td>1,200</td>
							<td>1,400-1,600</td>
							<td>1,400-1,800</td>
						</tr>
						<tr>
							<td>9-13</td>
							<td>1,600</td>
							<td>1,600-2,000</td>
							<td>1,800-2,200</td>
						</tr>
						<tr>
							<td>14-18</td>
							<td>1,800</td>
							<td>2,000</td>
							<td>2,400</td>
						</tr>
						<tr>
							<td>19-30</td>
							<td>2,000</td>
							<td>2,000-2,200</td>
							<td>2,400</td>
						</tr>
						<tr>
							<td>31-50</td>
							<td>1,800</td>
							<td>2,000</td>
							<td>2,200</td>
						</tr>
						<tr>
							<td>51+</td>
							<td>1,600</td>
							<td>1,800</td>
							<td>2,000-2,200</td>
						</tr>
						<tr>
							<td rowspan="6" style="vertical-align: middle">Male</td>
							<td>4-8</td>
							<td>1,400</td>
							<td>1,400-1,600</td>
							<td>1,600-2,000</td>
						</tr>
						<tr>
							<td>9-13</td>
							<td>1,800</td>
							<td>1,800-2,200</td>
							<td>2,000-2,600</td>
						</tr>
						<tr>
							<td>14-18</td>
							<td>2,200</td>
							<td>2,400-2,800</td>
							<td>2,800-3,200</td>
						</tr>
						<tr>
							<td>19-30</td>
							<td>2,400</td>
							<td>2,600-2,800</td>
							<td>3,000</td>
						</tr>
						<tr>
							<td>31-50</td>
							<td>2,200</td>
							<td>2,400-2,600</td>
							<td>2,800-3,000</td>
						</tr>
						<tr>
							<td>51+</td>
							<td>2,000</td>
							<td>2,200-2,400</td>
							<td>2,400-2,800</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>
<script>
   $(document).ready(function () {
 	    $('.slider').slider();
   });
</script>
