<%@page import="java.io.File"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.predicto.model.Daily_data" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@include file="header.jsp" %>
<%@include file="sidebar.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<script type="text/javascript" src="resources/js/chart.js"></script>
<script type="text/javascript" src="resources/js/chartjs.js"></script>
<link href="resources/css/main.css" rel="stylesheet"/>
<div class="box box-danger">
	<div class="box-header with-border">
		<h3 class="box-title">Running</h3>
		<div class="box-tools pull-right">
			<button class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
			<button class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
		</div>
	</div>
	<div class="box-body">
		<canvas id="barChart" style="height:250px"></canvas>
	</div><!-- /.box-body -->
</div>
<div class="box box-danger">
	<div class="box-header with-border">
		<h3 class="box-title">Walking</h3>
		<div class="box-tools pull-right">
			<button class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
			<button class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
		</div>
	</div>
	<div class="box-body">
		<canvas id="barChart1" style="height:250px"></canvas>
	</div><!-- /.box-body -->
</div>
<div class="box box-danger">
	<div class="box-header with-border">
		<h3 class="box-title">Cycling</h3>
		<div class="box-tools pull-right">
			<button class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
			<button class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
		</div>
	</div>
	<div class="box-body">
		<canvas id="barChart2" style="height:250px"></canvas>
	</div><!-- /.box-body -->
</div>
<div class="box box-danger">
	<div class="box-header with-border">
		<h3 class="box-title">Working out</h3>
		<div class="box-tools pull-right">
			<button class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
			<button class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
		</div>
	</div>
	<div class="box-body">
		<canvas id="barChart3" style="height:250px"></canvas>
	</div><!-- /.box-body -->
</div>
<div class="box box-danger">
	<div class="box-header with-border">
		<h3 class="box-title">Calories burnt</h3>
		<div class="box-tools pull-right">
			<button class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
			<button class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
		</div>
	</div>
	<div class="box-body">
		<canvas id="barChart4" style="height:250px"></canvas>
	</div><!-- /.box-body -->
</div>
<script>
$(function () {
	var d="${run}";
	var arr=d.split(",");
	
	var areaChartData = {
	          labels: [${x}],
	          datasets: [
	            {
	              label: "Electronics",
	              fillColor: "#4286f4",
	              strokeColor: "rgba(210, 214, 222, 1)",
	              pointColor: "rgba(210, 214, 222, 1)",
	              pointStrokeColor: "#c1c7d1",
	              pointHighlightFill: "#4286f4",
	              pointHighlightStroke: "rgba(220,220,220,1)",
	              data: arr
	            }
	           ]
	        };

	   var barChartCanvas = $("#barChart").get(0).getContext("2d");
       var barChart = new Chart(barChartCanvas);
       var barChartData = areaChartData;
       var barChartOptions = {
         //Boolean - Whether the scale should start at zero, or an order of magnitude down from the lowest value
         scaleBeginAtZero: true,
         //Boolean - Whether grid lines are shown across the chart
         scaleShowGridLines: true,
         //String - Colour of the grid lines
         scaleGridLineColor: "rgba(0,0,0,.05)",
         //Number - Width of the grid lines
         scaleGridLineWidth: 1,
         //Boolean - Whether to show horizontal lines (except X axis)
         scaleShowHorizontalLines: true,
         //Boolean - Whether to show vertical lines (except Y axis)
         scaleShowVerticalLines: true,
         //Boolean - If there is a stroke on each bar
         barShowStroke: true,
         //Number - Pixel width of the bar stroke
         barStrokeWidth: 1,
         //Number - Spacing between each of the X value sets
         barValueSpacing: 50,
         //Number - Spacing between data sets within X values
         barDatasetSpacing: 50,
         //String - A legend template
         legendTemplate: "",
         //Boolean - whether to make the chart responsive
         maintainAspectRatio: false
       };

       barChartOptions.datasetFill = false;
       barChart.Bar(barChartData, barChartOptions);
     });

</script>
<script>
$(function () {
	var d="${walk}";
	var arr=d.split(",");
	
	var areaChartData = {
	          labels: [${x}],
	          datasets: [
	     	            {
	     	              label: "Electronics",
	     	              fillColor: "#4286f4",
	     	              strokeColor: "rgba(210, 214, 222, 1)",
	     	              pointColor: "rgba(210, 214, 222, 1)",
	     	              pointStrokeColor: "#c1c7d1",
	     	              pointHighlightFill: "#4286f4",
	     	              pointHighlightStroke: "rgba(220,220,220,1)",
	     	              data: arr
	     	            }
	     	           ]
	     	        };

	     	   var barChartCanvas = $("#barChart1").get(0).getContext("2d");
	            var barChart = new Chart(barChartCanvas);
	            var barChartData = areaChartData;
	            var barChartOptions = {
	              //Boolean - Whether the scale should start at zero, or an order of magnitude down from the lowest value
	              scaleBeginAtZero: true,
	              //Boolean - Whether grid lines are shown across the chart
	              scaleShowGridLines: true,
	              //String - Colour of the grid lines
	              scaleGridLineColor: "rgba(0,0,0,.05)",
	              //Number - Width of the grid lines
	              scaleGridLineWidth: 1,
	              //Boolean - Whether to show horizontal lines (except X axis)
	              scaleShowHorizontalLines: true,
	              //Boolean - Whether to show vertical lines (except Y axis)
	              scaleShowVerticalLines: true,
	              //Boolean - If there is a stroke on each bar
	              barShowStroke: true,
	              //Number - Pixel width of the bar stroke
	              barStrokeWidth: 1,
	              //Number - Spacing between each of the X value sets
	              barValueSpacing: 50,
	              //Number - Spacing between data sets within X values
	              barDatasetSpacing: 50,
	              //String - A legend template
	              legendTemplate: "",
	              //Boolean - whether to make the chart responsive
	              maintainAspectRatio: false
	            };

       barChartOptions.datasetFill = false;
       barChart.Bar(barChartData, barChartOptions);
     });

</script>
<script>
$(function () {
	var d="${cycle}";
	var arr=d.split(",");
	
	var areaChartData = {
	          labels: [${x}],
	          datasets: [
	     	            {
	     	              label: "Electronics",
	     	              fillColor: "#4286f4",
	     	              strokeColor: "rgba(210, 214, 222, 1)",
	     	              pointColor: "rgba(210, 214, 222, 1)",
	     	              pointStrokeColor: "#c1c7d1",
	     	              pointHighlightFill: "#4286f4",
	     	              pointHighlightStroke: "rgba(220,220,220,1)",
	     	              data: arr
	     	            }
	     	           ]
	     	        };

	     	   var barChartCanvas = $("#barChart2").get(0).getContext("2d");
	            var barChart = new Chart(barChartCanvas);
	            var barChartData = areaChartData;
	            var barChartOptions = {
	              //Boolean - Whether the scale should start at zero, or an order of magnitude down from the lowest value
	              scaleBeginAtZero: true,
	              //Boolean - Whether grid lines are shown across the chart
	              scaleShowGridLines: true,
	              //String - Colour of the grid lines
	              scaleGridLineColor: "rgba(0,0,0,.05)",
	              //Number - Width of the grid lines
	              scaleGridLineWidth: 1,
	              //Boolean - Whether to show horizontal lines (except X axis)
	              scaleShowHorizontalLines: true,
	              //Boolean - Whether to show vertical lines (except Y axis)
	              scaleShowVerticalLines: true,
	              //Boolean - If there is a stroke on each bar
	              barShowStroke: true,
	              //Number - Pixel width of the bar stroke
	              barStrokeWidth: 1,
	              //Number - Spacing between each of the X value sets
	              barValueSpacing: 50,
	              //Number - Spacing between data sets within X values
	              barDatasetSpacing: 50,
	              //String - A legend template
	              legendTemplate: "",
	              //Boolean - whether to make the chart responsive
	              maintainAspectRatio: false
	            };

       barChartOptions.datasetFill = false;
       barChart.Bar(barChartData, barChartOptions);
     });

</script>
<script>
$(function () {
	var d="${work}";
	var arr=d.split(",");
	
	var areaChartData = {
	          labels: [${x}],
	          datasets: [
	     	            {
	     	              label: "Electronics",
	     	              fillColor: "#4286f4",
	     	              strokeColor: "rgba(210, 214, 222, 1)",
	     	              pointColor: "rgba(210, 214, 222, 1)",
	     	              pointStrokeColor: "#c1c7d1",
	     	              pointHighlightFill: "#4286f4",
	     	              pointHighlightStroke: "rgba(220,220,220,1)",
	     	              data: arr
	     	            }
	     	           ]
	     	        };

	     	   var barChartCanvas = $("#barChart3").get(0).getContext("2d");
	            var barChart = new Chart(barChartCanvas);
	            var barChartData = areaChartData;
	            var barChartOptions = {
	              //Boolean - Whether the scale should start at zero, or an order of magnitude down from the lowest value
	              scaleBeginAtZero: true,
	              //Boolean - Whether grid lines are shown across the chart
	              scaleShowGridLines: true,
	              //String - Colour of the grid lines
	              scaleGridLineColor: "rgba(0,0,0,.05)",
	              //Number - Width of the grid lines
	              scaleGridLineWidth: 1,
	              //Boolean - Whether to show horizontal lines (except X axis)
	              scaleShowHorizontalLines: true,
	              //Boolean - Whether to show vertical lines (except Y axis)
	              scaleShowVerticalLines: true,
	              //Boolean - If there is a stroke on each bar
	              barShowStroke: true,
	              //Number - Pixel width of the bar stroke
	              barStrokeWidth: 1,
	              //Number - Spacing between each of the X value sets
	              barValueSpacing: 50,
	              //Number - Spacing between data sets within X values
	              barDatasetSpacing: 50,
	              //String - A legend template
	              legendTemplate: "",
	              //Boolean - whether to make the chart responsive
	              maintainAspectRatio: false
	            };

       barChartOptions.datasetFill = false;
       barChart.Bar(barChartData, barChartOptions);
     });

</script>
<script>
$(function () {
	var d="${calories}";
	var arr=d.split(",");
	
	var areaChartData = {
	          labels: [${x}],
	          datasets: [
	     	            {
	     	              label: "Electronics",
	     	              fillColor: "#4286f4",
	     	              strokeColor: "rgba(210, 214, 222, 1)",
	     	              pointColor: "rgba(210, 214, 222, 1)",
	     	              pointStrokeColor: "#c1c7d1",
	     	              pointHighlightFill: "#4286f4",
	     	              pointHighlightStroke: "rgba(220,220,220,1)",
	     	              data: arr
	     	            }
	     	           ]
	     	        };

	     	   var barChartCanvas = $("#barChart4").get(0).getContext("2d");
	            var barChart = new Chart(barChartCanvas);
	            var barChartData = areaChartData;
	            var barChartOptions = {
	              //Boolean - Whether the scale should start at zero, or an order of magnitude down from the lowest value
	              scaleBeginAtZero: true,
	              //Boolean - Whether grid lines are shown across the chart
	              scaleShowGridLines: true,
	              //String - Colour of the grid lines
	              scaleGridLineColor: "rgba(0,0,0,.05)",
	              //Number - Width of the grid lines
	              scaleGridLineWidth: 1,
	              //Boolean - Whether to show horizontal lines (except X axis)
	              scaleShowHorizontalLines: true,
	              //Boolean - Whether to show vertical lines (except Y axis)
	              scaleShowVerticalLines: true,
	              //Boolean - If there is a stroke on each bar
	              barShowStroke: true,
	              //Number - Pixel width of the bar stroke
	              barStrokeWidth: 1,
	              //Number - Spacing between each of the X value sets
	              barValueSpacing: 50,
	              //Number - Spacing between data sets within X values
	              barDatasetSpacing: 50,
	              //String - A legend template
	              legendTemplate: "",
	              //Boolean - whether to make the chart responsive
	              maintainAspectRatio: false
	            };

       barChartOptions.datasetFill = false;
       barChart.Bar(barChartData, barChartOptions);
     });

</script>

</body>
</html>