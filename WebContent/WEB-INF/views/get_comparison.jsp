<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link href="resources/css/comparison.css" rel="stylesheet" type="text/css"/>
<%@ page import = "java.util.Map" %>
<script type="text/javascript" src="resources/js/chartjs.js"></script>
<c:set var="ids" value="${ids }"/>
<%
	String[] colors = {"#000","#3b8bba","#ba1616","#57ba16"};
	int lp;
	String ids = (String) pageContext.getAttribute("ids");
	int id_len = ids.split(",").length;
	id_len = (id_len <= 4) ? id_len : 4;
%>
<script type="text/javascript">
	var colors = ["#000","#3b8bba","#ba1616","#57ba16"];
	function format(dates)
	{
		var str;
		for(var d in dates)
		{
			str = new Date(dates[d]);
			dates[d] = str.toString().substring(4,10);
		}
		return dates;
	}
	var chartOptions = {
        //Boolean - If we should show the scale at all
        showScale: true,
        //Boolean - Whether grid lines are shown across the chart
        scaleShowGridLines: false,
        //String - Colour of the grid lines
        scaleGridLineColor: "rgba(0,0,0,.05)",
        //Number - Width of the grid lines
        scaleGridLineWidth: 1,
        //Boolean - Whether to show horizontal lines (except X axis)
        scaleShowHorizontalLines: true,
        //Boolean - Whether to show vertical lines (except Y axis)
        scaleShowVerticalLines: true,
        //Boolean - Whether the line is curved between points
        bezierCurve: true,
        //Number - Tension of the bezier curve between points
        bezierCurveTension: 0.3,
        //Boolean - Whether to show a dot for each point
        pointDot: false,
        //Number - Radius of each point dot in pixels
        pointDotRadius: 4,
        //Number - Pixel width of point dot stroke
        pointDotStrokeWidth: 1,
        //Number - amount extra to add to the radius to cater for hit detection outside the drawn point
        pointHitDetectionRadius: 20,
        //Boolean - Whether to show a stroke for datasets
        datasetStroke: true,
        //Number - Pixel width of dataset stroke
        datasetStrokeWidth: 5,
        //Boolean - Whether to fill the dataset with a color
        datasetFill: true,
        //Boolean - whether to maintain the starting aspect ratio or not when responsive, if set to false, will take up entire container
        maintainAspectRatio: true,
        //Boolean - whether to make the chart responsive to window resizing
        
      };
</script>
<c:set var="len" value="${fn:length(friends)}"></c:set>
<c:if test="${fn:length(friends) gt 0}">
	<div class="col-md-12">
		<div class="row" id="comparison_head">
			<div class="col-sm-2 head_name" id="head_hash">
				#
			</div>
			<div class="col-sm-2 head_name user_name">
				You
			</div>
			<c:forEach begin="1" end="${len-1}" varStatus="loop">
				<div class="col-sm-2 head_name">
					${friends[loop.index].username}
				</div>
			</c:forEach>
		</div>
		<div class="row" id="comparison_body">
			<div class="comparison_row col-sm-12 lr0pad" id="bmi_div">
				<div class="col-sm-2 row_title row_data">
					BMI
				</div>
				<c:forEach items="${friends}" var="fr" varStatus="loop">
					<c:choose>
						<c:when test="${fr.bmi gt 30}">
							<c:set var="cls" value="danger"/>
							<c:set var="tip" value="${fr.bmi} (Obese)"/>
						</c:when>
						<c:when test="${fr.bmi gt 25}">	
							<c:set var="cls" value="warning"/>
							<c:set var="tip" value="${fr.bmi} (Overweight)"/>
						</c:when>
						<c:when test="${fr.bmi gt 18.5}">
							<c:set var="cls" value="success"/>
							<c:set var="tip" value="${fr.bmi} (Normal)"/>
						</c:when>
						<c:otherwise>
							<c:set var="cls" value="danger"/>
							<c:set var="tip" value="${fr.bmi} (Underweight)"/>
						</c:otherwise>
					</c:choose>
					<c:if test="${loop.index eq 0}">
						<div class="col-sm-2 user_data row_data">
							<div class="progress progress_tip tip_${cls} pointer" data-toggle="tooltip" data-placement="bottom" title="${tip}" style="width: 90%;">
								<div class="progress-bar progress-bar-${cls} text-center" role="progressbar" aria-valuenow="25" aria-valuemin="1" aria-valuemax="50" wid="${fr.bmi*2}">
									${fr.bmi}
								</div>
							</div>
						</div>
					</c:if>
					<c:if test="${loop.index gt 0}">
						<div class="col-sm-2 friend_data row_data">
							<div class="progress progress_tip tip_${cls} pointer" data-toggle="tooltip" data-placement="bottom" title="${tip}" style="width: 90%;">
								<div class="progress-bar progress-bar-${cls} text-center" role="progressbar" aria-valuenow="25" aria-valuemin="1" aria-valuemax="50" wid="${fr.bmi*2}">
									${fr.bmi}
								</div>
							</div>
						</div>
					</c:if>
				</c:forEach>
			</div>
			<div class="comparison_row col-sm-12 lr0pad" id="age_div">
				<div class="col-sm-2 row_title row_data">
					Weight (Kgs)
				</div>
				<c:forEach items="${friends}" var="fr" varStatus="loop">
					<c:if test="${loop.index eq 0}">
						<div class="col-sm-2 user_data row_data">
							<p><strong>${fr.weight }</strong></p>
						</div>
					</c:if>
					<c:if test="${loop.index gt 0}">
						<div class="col-sm-2 friend_data row_data">
							<p><strong>${fr.weight }</strong></p>
						</div>
					</c:if>
				</c:forEach>
			</div>
			<div class="comparison_row col-sm-12 lr0pad" id="age_div">
				<div class="col-sm-2 row_title row_data">
					Height (cms)
				</div>
				<c:forEach items="${friends}" var="fr" varStatus="loop">
					<c:if test="${loop.index eq 0}">
						<div class="col-sm-2 user_data row_data">
							<p><strong>${fr.height }</strong></p>
						</div>
					</c:if>
					<c:if test="${loop.index gt 0}">
						<div class="col-sm-2 friend_data row_data">
							<p><strong>${fr.height }</strong></p>
						</div>
					</c:if>
				</c:forEach>
			</div>
			<div class="comparison_row col-sm-12 lr0pad" id="age_div">
				<div class="col-sm-2 row_title row_data">
					Age (Years)
				</div>
				<c:forEach items="${friends}" var="fr" varStatus="loop">
					<c:if test="${loop.index eq 0}">
						<div class="col-sm-2 user_data row_data">
							<p><strong>${fr.age }</strong></p>
						</div>
					</c:if>
					<c:if test="${loop.index gt 0}">
						<div class="col-sm-2 friend_data row_data">
							<p><strong>${fr.age }</strong></p>
						</div>
					</c:if>
				</c:forEach>
			</div>
			<div class="comparison_row col-sm-12 lr0pad chart_div" id="run_div">
				<div class="col-sm-2 row_title row_data">
					Running
				</div>
				<div class="col-sm-<%= 2+id_len*2%> user_data row_data">
					<div class="col-sm-3 label_div">
						<p class="user_0"><span class="color">&nbsp;&nbsp;&nbsp;&nbsp;</span> - <span class="name"></span></p>
						<%
							for(int k = 1; k <= id_len; k++)
							{
								out.println("<p class=\"user_"+k+"\"><span class=\"color\">&nbsp;&nbsp;&nbsp;&nbsp;</span> - <span class=\"name\"></span></p>");
							}
						%>
					</div>
					<div class="col-sm-9">
						<canvas id="runChart" style="height: 140px"></canvas>
					</div>
				</div>
				<% lp=0; %>
				<script>
					var dates = [${run[0]}];
					dates = format(dates);
					  var runChartData = {
				        labels: dates,
				        datasets: [
						<c:forEach items="${run}" var="fr" varStatus="loop">
							<c:if test="${not loop.first}">
								{
						            label: "Electronics",
						            fillColor: "rgba(210, 214, 222, 1)",
						            strokeColor: "<%= colors[lp%colors.length]%>",
						            pointColor: "rgba(210, 214, 222, 1)",
						            pointStrokeColor: "#c1c7d1",
						            pointHighlightFill: "#fff",
						            pointHighlightStroke: "rgba(220,220,220,1)",
						            data: [${fr}]
								},
								<% lp++;%>
							</c:if>
						</c:forEach>
				        ]
				      };
				</script>
				
			</div>
			<div class="comparison_row col-sm-12 lr0pad chart_div" id="walk_div">
				<div class="col-sm-2 row_title row_data">
					Walking
				</div>
				<div class="col-sm-<%= 2+id_len*2%> user_data row_data">
					<div class="col-sm-3 label_div">
						<p class="user_0"><span class="color">&nbsp;&nbsp;&nbsp;&nbsp;</span> - <span class="name"></span></p>
						<%
							for(int k = 1; k <= id_len; k++)
							{
								out.println("<p class=\"user_"+k+"\"><span class=\"color\">&nbsp;&nbsp;&nbsp;&nbsp;</span> - <span class=\"name\"></span></p>");
							}
						%>
					</div>
					<div class="col-sm-9">
						<canvas id="walkChart" style="height: 140px"></canvas>
					</div>
				</div>
				<% lp=0; %>
				<script>
					var dates = [${walk[0]}];
					dates = format(dates);
					  var walkChartData = {
				        labels: dates,
				        datasets: [
						<c:forEach items="${walk}" var="fr" varStatus="loop">
							<c:if test="${not loop.first}">
								{
						            label: "Electronics",
						            fillColor: "rgba(210, 214, 222, 1)",
						            strokeColor: "<%= colors[lp%colors.length]%>",
						            pointColor: "rgba(210, 214, 222, 1)",
						            pointStrokeColor: "#c1c7d1",
						            pointHighlightFill: "#fff",
						            pointHighlightStroke: "rgba(220,220,220,1)",
						            data: [${fr}]
								},
								<% lp++;%>
							</c:if>
						</c:forEach>
				        ]
				      };
				</script>
				
			</div>
			<div class="comparison_row col-sm-12 lr0pad chart_div" id="cycle_div">
				<div class="col-sm-2 row_title row_data">
					Cycling
				</div>
				<div class="col-sm-<%= 2+id_len*2%> user_data row_data">
					<div class="col-sm-3 label_div">
						<p class="user_0"><span class="color">&nbsp;&nbsp;&nbsp;&nbsp;</span> - <span class="name"></span></p>
						<%
							for(int k = 1; k <= id_len; k++)
							{
								out.println("<p class=\"user_"+k+"\"><span class=\"color\">&nbsp;&nbsp;&nbsp;&nbsp;</span> - <span class=\"name\"></span></p>");
							}
						%>
					</div>
					<div class="col-sm-9">
						<canvas id="cycleChart" style="height: 140px"></canvas>
					</div>
				</div>
				<% lp=0; %>
				<script>
					var dates = [${cycle[0]}];
					dates = format(dates);
					  var cycleChartData = {
				        labels: dates,
				        datasets: [
						<c:forEach items="${cycle}" var="fr" varStatus="loop">
							<c:if test="${not loop.first}">
								{
						            label: "Electronics",
						            fillColor: "rgba(210, 214, 222, 1)",
						            strokeColor: "<%= colors[lp%colors.length]%>",
						            pointColor: "rgba(210, 214, 222, 1)",
						            pointStrokeColor: "#c1c7d1",
						            pointHighlightFill: "#fff",
						            pointHighlightStroke: "rgba(220,220,220,1)",
						            data: [${fr}]
								},
								<% lp++;%>
							</c:if>
						</c:forEach>
				        ]
				      };
				</script>
				
			</div>
			<div class="comparison_row col-sm-12 lr0pad chart_div" id="work_div">
				<div class="col-sm-2 row_title row_data">
					Work out
				</div>
				<div class="col-sm-<%= 2+id_len*2%> user_data row_data">
					<div class="col-sm-3 label_div">
						<p class="user_0"><span class="color">&nbsp;&nbsp;&nbsp;&nbsp;</span> - <span class="name"></span></p>
						<%
							for(int k = 1; k <= id_len; k++)
							{
								out.println("<p class=\"user_"+k+"\"><span class=\"color\">&nbsp;&nbsp;&nbsp;&nbsp;</span> - <span class=\"name\"></span></p>");
							}
						%>
					</div>
					<div class="col-sm-9">
						<canvas id="workChart" style="height: 140px"></canvas>
					</div>
				</div>
				<% lp=0; %>
				<script>
					var dates = [${working[0]}];
					dates = format(dates);
					  var workChartData = {
				        labels: dates,
				        datasets: [
						<c:forEach items="${run}" var="fr" varStatus="loop">
							<c:if test="${not loop.first}">
								{
						            label: "Electronics",
						            fillColor: "rgba(210, 214, 222, 1)",
						            strokeColor: "<%= colors[lp%colors.length]%>",
						            pointColor: "rgba(210, 214, 222, 1)",
						            pointStrokeColor: "#c1c7d1",
						            pointHighlightFill: "#fff",
						            pointHighlightStroke: "rgba(220,220,220,1)",
						            data: [${fr}]
								},
								<% lp++;%>
							</c:if>
						</c:forEach>
				        ]
				      };
				</script>
			</div>
		</div>
	</div>
</c:if>
<c:if test="${fn:length(friends) eq 0}">
	<h2 class="text-center">Invalid Comparison! <a href="friend/compare">Retry?</a></h2>
</c:if>


<script>
      var runChartCanvas = $("#runChart").get(0).getContext("2d");
      var runChart = new Chart(runChartCanvas);
      var runChartOptions = chartOptions;
      runChartOptions.datasetFill = false;
      runChart.Line(runChartData, runChartOptions);
      
      var walkChartCanvas = $("#walkChart").get(0).getContext("2d");
      var walkChart = new Chart(walkChartCanvas);
      var walkChartOptions = chartOptions;
      walkChartOptions.datasetFill = false;
      walkChart.Line(walkChartData, walkChartOptions);
      
      var cycleChartCanvas = $("#cycleChart").get(0).getContext("2d");
      var cycleChart = new Chart(cycleChartCanvas);
      var cycleChartOptions = chartOptions;
      cycleChartOptions.datasetFill = false;
      cycleChart.Line(cycleChartData, cycleChartOptions);
      
      var workChartCanvas = $("#workChart").get(0).getContext("2d");
      var workChart = new Chart(workChartCanvas);
      var workChartOptions = chartOptions;
      workChartOptions.datasetFill = false;
      workChart.Line(workChartData, workChartOptions);
</script>

	