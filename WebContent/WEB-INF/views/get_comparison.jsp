<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link href="resources/css/comparison.css" rel="stylesheet" type="text/css"/>
<%@ page import = "java.util.Map" %>
<script type="text/javascript" src="resources/js/chartjs.js"></script>
<script type="text/javascript">
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
        datasetStrokeWidth: 2,
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
			<div class="comparison_row col-sm-12 lr0pad" id="chart_div">
				<div class="col-sm-2 row_title row_data">
					Running
				</div>
				<div class="col-sm-6 user_data row_data">
					<canvas id="runChart" style="height: 140px"></canvas>
				</div>
				<script>
					  var runChartData = {
				        labels: ["January", "February", "March", "April", "May", "June", "July"],
				        datasets: [
				          {
				            label: "Electronics",
				            fillColor: "rgba(210, 214, 222, 1)",
				            strokeColor: "rgba(210, 214, 222, 1)",
				            pointColor: "rgba(210, 214, 222, 1)",
				            pointStrokeColor: "#c1c7d1",
				            pointHighlightFill: "#fff",
				            pointHighlightStroke: "rgba(220,220,220,1)",
				            data: [65, 59, 80, 81, 56, 55, 40]
				          },
				          {
				            label: "Digital Goods",
				            fillColor: "rgba(60,141,188,0.9)",
				            strokeColor: "rgba(60,141,188,0.8)",
				            pointColor: "#3b8bba",
				            pointStrokeColor: "rgba(60,141,188,1)",
				            pointHighlightFill: "#fff",
				            pointHighlightStroke: "rgba(60,141,188,1)",
				            data: [28, 48, 40, 19, 86, 27, 90]
				          }
				        ]
				      };
				</script>
				<c:forEach items="${friends}" var="fr" varStatus="loop">
					
				</c:forEach>
			</div>
		</div>
	</div>
</c:if>
<div class="box-header with-border">
		<h3 class="box-title">Running</h3>
	</div>
	<div class="box-body">
		<canvas id="lineChart" style="height:250px"></canvas>
	</div><!-- /.box-body -->
</div>

<c:forEach items="${run}" var="fr" varStatus="loop">
${fr }<br/>
</c:forEach>

<%-- 
${walk}
${cycle}
${work} --%>
<c:if test="${fn:length(friends) eq 0}">
	<h2 class="text-center">Invalid Comparison! <a href="friend/compare">Retry?</a></h2>
</c:if>


<script>
      var runChartCanvas = $("#runChart").get(0).getContext("2d");
      var runChart = new Chart(runChartCanvas);
      var runChartOptions = chartOptions;
      runChartOptions.datasetFill = false;
      runChart.Line(runChartData, runChartOptions);
</script>

	