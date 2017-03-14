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
		<h3 class="box-title">Donut Chart</h3>
		<div class="box-tools pull-right">
			<button class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
			<button class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
		</div>
	</div>
	<div class="box-body">
		<canvas id="pieChart" style="height:250px"></canvas>
	</div><!-- /.box-body -->
</div>
<script>
$(function () {
	var pieChartCanvas = $("#pieChart").get(0).getContext("2d");
	var pieChart = new Chart(pieChartCanvas);
	var PieData = [
	  {
	    value: 700,
	    color: "#f56954",
	    highlight: "#f56954",
	    label: "Chrome"
	  },
	  {
	    value: 500,
	    color: "#00a65a",
	    highlight: "#00a65a",
	    label: "IE"
	  },
	  {
	    value: 400,
	    color: "#f39c12",
	    highlight: "#f39c12",
	    label: "FireFox"
	  },
	  {
	    value: 600,
	    color: "#00c0ef",
	    highlight: "#00c0ef",
	    label: "Safari"
	  },
	  {
	    value: 300,
	    color: "#3c8dbc",
	    highlight: "#3c8dbc",
	    label: "Opera"
	  },
	  {
	    value: 100,
	    color: "#d2d6de",
	    highlight: "#d2d6de",
	    label: "Navigator"
	  }
	];
	var pieOptions = {
	  //Boolean - Whether we should show a stroke on each segment
	  segmentShowStroke: true,
	  //String - The colour of each segment stroke
	  segmentStrokeColor: "#fff",
	  //Number - The width of each segment stroke
	  segmentStrokeWidth: 2,
	  //Number - The percentage of the chart that we cut out of the middle
	  percentageInnerCutout: 50, // This is 0 for Pie charts
	  //Number - Amount of animation steps
	  animationSteps: 100,
	  //String - Animation easing effect
	  animationEasing: "easeOutBounce",
	  //Boolean - Whether we animate the rotation of the Doughnut
	  animateRotate: true,
	  //Boolean - Whether we animate scaling the Doughnut from the centre
	  animateScale: false,
	  //Boolean - whether to make the chart responsive to window resizing
	  responsive: true,
	  // Boolean - whether to maintain the starting aspect ratio or not when responsive, if set to false, will take up entire container
	  maintainAspectRatio: true,
	  //String - A legend template
	  <%-- legendTemplate: "<ul class=\"<%=name.toLowerCase()%>-legend\"><% for (var i=0; i<segments.length; i++){%><li><span style=\"background-color:<%=segments[i].fillColor%>\"></span><%if(segments[i].label){%><%=segments[i].label%><%}%></li><%}%></ul>" --%>
	};
	//Create pie or douhnut chart
	// You can switch between pie and douhnut using the method below.
	pieChart.Doughnut(PieData, pieOptions);
});
</script>
<c:set var="j" value="${run}"/>
<%
	String s=(String)pageContext.getAttribute("j");
	out.println(s);	
	String[] temp=s.split(",");
	int i=temp.length;
%>
	<select class="form-control" id="graph_type" name="graph_type" style="cursor: pointer">
			<option value="pie" selected>Pie Chart</option>
			<option value="bar">Bar Chart</option>
			<option value="line">Line Chart</option>
			<option value="radar">Radar Chart</option>
			<option value="doughnut">Doughnut Chart</option>
			<option value="polarArea">Polar Area Chart</option>
		</select>
	 <canvas id="myChart" width="600" height="300"></canvas>
	 <br>
	 <canvas id="myChart1" width="600" height="300"></canvas>
	 <br>
	 <canvas id="myChart2" width="600" height="300"></canvas>
	 <br>
	 <canvas id="myChart3" width="600" height="300"></canvas>
	<script>
		var colors = ['rgba(255, 99, 132, 0.4)', 'rgba(54, 162, 235, 0.4)', 'rgba(255, 206, 86, 0.4)',
		                'rgba(75, 192, 192, 0.4)', 'rgba(153, 102, 255, 0.4)', 'rgba(255, 159, 64, 0.4)']
		var ctx = document.getElementById("myChart");
		var config = {
			    type: 'bar',
			    data: {
			        labels: [${x}],
			        datasets: [{
			            label: '# of kms ran',
			            data: [${run}],
			            backgroundColor: [
			              <% 
			              for(int p=0; p<i; p++)
			              {
			            	out.println("colors["+(p%6)+"],");
			              }
			              %>
			            ],
			            borderColor: [
						<% 
						for(int p=0; p<i; p++)
						{
							out.println("colors["+(p%6)+"],");
						}
						%> 
			            ],
			            borderWidth: 1,
			        }]
			    },
			    options: {
			        scales: {
			        	xAxes:[{
			        		barThickness: 30
			        	}],
			            yAxes: [{
			                ticks: {
			                    beginAtZero:true
			                }
			            }]
			        }
			    }
			};
		var temp = jQuery.extend(true, {}, config);
		var myChart = new Chart(ctx, temp);
	</script>
	<script>
		var colors = ['rgba(255, 99, 132, 0.4)', 'rgba(54, 162, 235, 0.4)', 'rgba(255, 206, 86, 0.4)',
		                'rgba(75, 192, 192, 0.4)', 'rgba(153, 102, 255, 0.4)', 'rgba(255, 159, 64, 0.4)']
		var ctx = document.getElementById("myChart1");
		var config = {
			    type: 'bar',
			    data: {
			        labels: [${x}],
			        datasets: [{
			            label: '# of kms worked out',
			            data: [${work}],
			            backgroundColor: [
			              <% 
			              for(int p=0; p<i; p++)
			              {
			            	out.println("colors["+(p%6)+"],");
			              }
			              %>
			            ],
			            borderColor: [
						<% 
						for(int p=0; p<i; p++)
						{
							out.println("colors["+(p%6)+"],");
						}
						%> 
			            ],
			            borderWidth: 1,
			        }]
			    },
			    options: {
			        scales: {
			        	xAxes:[{
			        		barThickness: 30
			        	}],
			            yAxes: [{
			                ticks: {
			                    beginAtZero:true
			                }
			            }]
			        }
			    }
			};
		var temp = jQuery.extend(true, {}, config);
		var myChart = new Chart(ctx, temp);
	</script>
	<script>
		var colors = ['rgba(255, 99, 132, 0.4)', 'rgba(54, 162, 235, 0.4)', 'rgba(255, 206, 86, 0.4)',
		                'rgba(75, 192, 192, 0.4)', 'rgba(153, 102, 255, 0.4)', 'rgba(255, 159, 64, 0.4)']
		var ctx = document.getElementById("myChart2");
		var config = {
			    type: 'bar',
			    data: {
			        labels: [${x}],
			        datasets: [{
			            label: '# of kms Cycled',
			            data: [${cycle}],
			            backgroundColor: [
			              <% 
			              for(int p=0; p<i; p++)
			              {
			            	out.println("colors["+(p%6)+"],");
			              }
			              %>
			            ],
			            borderColor: [
						<% 
						for(int p=0; p<i; p++)
						{
							out.println("colors["+(p%6)+"],");
						}
						%> 
			            ],
			            borderWidth: 1,
			        }]
			    },
			    options: {
			        scales: {
			        	xAxes:[{
			        		barThickness: 30
			        	}],
			            yAxes: [{
			                ticks: {
			                    beginAtZero:true
			                }
			            }]
			        }
			    }
			};
		var temp = jQuery.extend(true, {}, config);
		var myChart = new Chart(ctx, temp);
	</script>
	<script>
		var colors = ['rgba(255, 99, 132, 0.4)', 'rgba(54, 162, 235, 0.4)', 'rgba(255, 206, 86, 0.4)',
		                'rgba(75, 192, 192, 0.4)', 'rgba(153, 102, 255, 0.4)', 'rgba(255, 159, 64, 0.4)']
		var ctx = document.getElementById("myChart3");
		var config = {
			    type: 'bar',
			    data: {
			        labels: [${x}],
			        datasets: [{
			            label: '# of kms walked',
			            data: [${walk}],
			            backgroundColor: [
			              <% 
			              for(int p=0; p<i; p++)
			              {
			            	out.println("colors["+(p%6)+"],");
			              }
			              %>
			            ],
			            borderColor: [
						<% 
						for(int p=0; p<i; p++)
						{
							out.println("colors["+(p%6)+"],");
						}
						%> 
			            ],
			            borderWidth: 1,
			        }]
			    },
			    options: {
			        scales: {
			        	xAxes:[{
			        		barThickness: 30
			        	}],
			            yAxes: [{
			                ticks: {
			                    beginAtZero:true
			                }
			            }]
			        }
			    }
			};
		var temp = jQuery.extend(true, {}, config);
		var myChart = new Chart(ctx, temp);
	</script>
	<script type="text/javascript">
		$(document).ready(function()
		{
			$("#graph_type").change(function()
			{
				if (myChart) {
				    myChart.destroy();
				  }
				var temp = jQuery.extend(true, {}, config);
				temp.type = $(this).val();
				myChart = new Chart(ctx, temp);
			});
		});
	</script>

</body>
</html>