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
<div class="box box-primary">
	<div class="box-header with-border">
		<h3 class="box-title">Running</h3>
		<div class="box-tools pull-right">
			<button class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
			<button class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
		</div>
	</div>
	<div class="box-body">
		<div class="chart" id="run_chart" style="height: 250px;"></div>
	</div><!-- /.box-body -->
</div>
<div class="box box-danger cbox">
	<div class="box-header with-border">
		<h3 class="box-title">Walking</h3>
		<div class="box-tools pull-right">
			<button class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-plus"></i></button>
			<button class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
		</div>
	</div>
	<div class="box-body">
		<div class="chart" id="walk_chart" style="height: 250px;"></div>
	</div><!-- /.box-body -->
</div>
<div class="box box-primary cbox">
	<div class="box-header with-border">
		<h3 class="box-title">Cycling</h3>
		<div class="box-tools pull-right">
			<button class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-plus"></i></button>
			<button class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
		</div>
	</div>
	<div class="box-body">
		<div class="chart" id="cycle_chart" style="height: 250px;"></div>
	</div><!-- /.box-body -->
</div>
<div class="box box-danger cbox">
	<div class="box-header with-border">
		<h3 class="box-title">Working out</h3>
		<div class="box-tools pull-right">
			<button class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-plus"></i></button>
			<button class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
		</div>
	</div>
	<div class="box-body">
		<div class="chart" id="work_out_chart" style="height: 250px;"></div>
	</div><!-- /.box-body -->
</div>
<div class="box box-primary cbox">
	<div class="box-header with-border">
		<h3 class="box-title">Calories burnt</h3>
		<div class="box-tools pull-right">
			<button class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-plus"></i></button>
			<button class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
		</div>
	</div>
	<div class="box-body">
		<div class="chart" id="calories_chart" style="height: 250px;"></div>
	</div><!-- /.box-body -->
</div>
<script>
	var run = new Morris.Line({
	    element: 'run_chart',
	    resize: true,
	    data: [${run}],
	    xkey: 'year',
	    ykeys: ['value'],
	    xLabels: "day",
	    xLabelFormat: function(x){ return x.toString().substring(4,15); },
	    labels: ['Run Count'],
	    lineColors: ['#3c8dbc'],
	    hideHover: 'auto'
	  });
	
	var walk = new Morris.Line({
	    element: 'walk_chart',
	    resize: true,
	    data: [${walk}],
	    xkey: 'year',
	    ykeys: ['value'],
	    xLabels: "day",
	    xLabelFormat: function(x){ return x.toString().substring(4,15); },
	    labels: ['Walk Count'],
	    lineColors: ['#3c8dbc'],
	    hideHover: 'auto'
	  });
	var cycle = new Morris.Line({
	    element: 'cycle_chart',
	    resize: true,
	    data: [${cycle}],
	    xkey: 'year',
	    ykeys: ['value'],
	    xLabels: "day",
	    xLabelFormat: function(x){ return x.toString().substring(4,15); },
	    labels: ['Cycling Count'],
	    lineColors: ['#3c8dbc'],
	    hideHover: 'auto'
	  });
	var work = new Morris.Line({
	    element: 'work_out_chart',
	    resize: true,
	    data: [${work}],
	    xkey: 'year',
	    ykeys: ['value'],
	    xLabels: "day",
	    xLabelFormat: function(x){ return x.toString().substring(4,15); },
	    labels: ['Work Count'],
	    lineColors: ['#3c8dbc'],
	    hideHover: 'auto'
	  });
	var calories = new Morris.Line({
	    element: 'calories_chart',
	    resize: true,
	    data: [${calories}],
	    xkey: 'year',
	    ykeys: ['value'],
	    xLabels: "day",
	    xLabelFormat: function(x){ return x.toString().substring(4,15); },
	    labels: ['Calories Count'],
	    lineColors: ['#3c8dbc'],
	    hideHover: 'auto'
	  });
	$(".cbox").addClass("collapsed-box");
</script>
</body>
</html>