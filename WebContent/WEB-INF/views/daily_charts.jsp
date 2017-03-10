<%@page import="java.io.File"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.predicto.model.Daily_data" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@include file="header.jsp" %>
<%@include file="sidebar.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
	<script type="text/javascript" src="resources/js/chart.js"></script>
	<script type="text/javascript" src="resources/js/bootstrap.js"></script>
	<script type="text/javascript" src="resources/js/jquery.js"></script>
	<link href="resources/css/main.css" rel="stylesheet"/>
</head>


<body>
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