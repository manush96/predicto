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
<div class="box box-primary">
	<div class="box-header with-border">
		<h3 class="box-title">Walking</h3>
		<div class="box-tools pull-right">
			<button class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
			<button class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
		</div>
	</div>
	<div class="box-body">
		<div class="chart" id="walk_chart" style="height: 250px;"></div>
	</div><!-- /.box-body -->
</div>
<div class="box box-primary">
	<div class="box-header with-border">
		<h3 class="box-title">Cycling</h3>
		<div class="box-tools pull-right">
			<button class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
			<button class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
		</div>
	</div>
	<div class="box-body">
		<div class="chart" id="cycle_chart" style="height: 250px;"></div>
	</div><!-- /.box-body -->
</div>
<div class="box box-primary">
	<div class="box-header with-border">
		<h3 class="box-title">Working out</h3>
		<div class="box-tools pull-right">
			<button class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
			<button class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
		</div>
	</div>
	<div class="box-body">
		<div class="chart" id="work_out_chart" style="height: 250px;"></div>
	</div><!-- /.box-body -->
</div>
<div class="box box-primary">
	<div class="box-header with-border">
		<h3 class="box-title">Calories burnt</h3>
		<div class="box-tools pull-right">
			<button class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
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
	
<<<<<<< HEAD
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

</script>
=======
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
         barStrokeWidth: 2,
         //Number - Spacing between each of the X value sets
         barValueSpacing: 3,
         //Number - Spacing between data sets within X values
         barDatasetSpacing: 1,
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
	              barStrokeWidth: 2,
	              //Number - Spacing between each of the X value sets
	              barValueSpacing: 3,
	              //Number - Spacing between data sets within X values
	              barDatasetSpacing: 1,
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
	              barStrokeWidth: 2,
	              //Number - Spacing between each of the X value sets
	              barValueSpacing: 3,
	              //Number - Spacing between data sets within X values
	              barDatasetSpacing: 1,
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
	              barStrokeWidth: 2,
	              //Number - Spacing between each of the X value sets
	              barValueSpacing: 3,
	              //Number - Spacing between data sets within X values
	              barDatasetSpacing: 1,
	              //String - A legend template
	              legendTemplate: "",
	              //Boolean - whether to make the chart responsive
	              maintainAspectRatio: false
	            };

       barChartOptions.datasetFill = false;
       barChart.Bar(barChartData, barChartOptions);
     });

</script>

>>>>>>> a2e99b225f57fa880214afbfa5f248664dde358b
</body>
</html>