<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@include file="header.jsp" %>
<%@include file="sidebar.jsp" %>
<c:set var="run" value="${run}"/>
<c:set var="walk" value="${walk}"/>
<c:set var="cycle" value="${cycle}"/>
<c:set var="working" value="${working}"/>
<c:set var="calories" value="${calories}"/>
<%!
	public String get_time(int mins)
	{
		if(mins > 60)
			return mins/60 + "h " + mins%60 + "m";
		else
			return mins + "m";
	}
%>
<%
	String tm;
	int run = (int) Double.parseDouble((String)pageContext.getAttribute("run"));
	int walk = (int) Double.parseDouble((String)pageContext.getAttribute("walk"));
	int foot = run+walk;
	
	int cycle = (int) Double.parseDouble((String)pageContext.getAttribute("cycle"));
	int working = (int) Double.parseDouble((String)pageContext.getAttribute("working"));
	String work_str = get_time(working);
	int calories = (int) Double.parseDouble((String)pageContext.getAttribute("calories"));
	int water= (Integer)pageContext.getAttribute("water_goal");

%>
<div class="row">
  <div class="col-md-3 col-sm-6 col-xs-12">
    <div class="info-box">
      <span class="info-box-icon bg-yellow"><i class="ion ion-android-walk"></i></span>
      <div class="info-box-content">
        <span class="info-box-text">On Foot</span>
        <span class="info-box-number"><%=foot %> <small>kms</small></span>
      </div><!-- /.info-box-content -->
    </div><!-- /.info-box -->
  </div><!-- /.col -->
  <div class="col-md-3 col-sm-6 col-xs-12">
    <div class="info-box">
      <span class="info-box-icon bg-red"><i class="ion ion-android-bicycle"></i></span>
      <div class="info-box-content">
        <span class="info-box-text">Cycling</span>
        <span class="info-box-number"><%=cycle %> <small>kms</small></span>
      </div><!-- /.info-box-content -->
    </div><!-- /.info-box -->
  </div><!-- /.col -->

  <!-- fix for small devices only -->
  <div class="clearfix visible-sm-block"></div>

  <div class="col-md-3 col-sm-6 col-xs-12">
    <div class="info-box">
      <span class="info-box-icon bg-green"><i class="ion ion-ios-timer-outline"></i></span>
      <div class="info-box-content">
        <span class="info-box-text">Work out</span>
        <span class="info-box-number"><%=work_str %></span>
      </div><!-- /.info-box-content -->
    </div><!-- /.info-box -->
  </div><!-- /.col -->
  <div class="col-md-3 col-sm-6 col-xs-12">
    <div class="info-box">
      <span class="info-box-icon bg-teal"><i class="ion ion-arrow-graph-down-right"></i></span>
      <div class="info-box-content">
        <span class="info-box-text">Calories Lost</span>
        <span class="info-box-number"><%=calories %></span>
      </div><!-- /.info-box-content -->
    </div><!-- /.info-box -->
  </div><!-- /.col -->
</div><!-- /.row -->
<div class="row">
   <div class="col-md-12">
     <div class="box">
       <div class="box-header with-border">
         <h3 class="box-title">Weekly calorie chart</h3>
         <div class="box-tools pull-right">
           <button class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
           <div class="btn-group">
             <button class="btn btn-box-tool dropdown-toggle" data-toggle="dropdown"><i class="fa fa-wrench"></i></button>
             <ul class="dropdown-menu" role="menu">
               <li><a href="#">Action</a></li>
               <li><a href="#">Another action</a></li>
               <li><a href="#">Something else here</a></li>
               <li class="divider"></li>
               <li><a href="#">Separated link</a></li>
             </ul>
           </div>
           <button class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
         </div>
       </div><!-- /.box-header -->
       <div class="box-body">
         <div class="row">
           <div class="col-md-8">
             <p class="text-center">
               <strong>Calories: <span id="start_date"></span> - <span id="end_date"></span></strong>
               <span class="pull-right">
               		<span class="label label-default">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span> - Calories Burnt<br/>
               		&nbsp;<span class="label label-primary">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span> - Calories Intake
               </span>
             </p>
             <div class="chart">
               <!-- Sales Chart Canvas -->
               <canvas id="salesChart" style="height: 180px;"></canvas>
             </div><!-- /.chart-responsive -->
           </div><!-- /.col -->
           <div class="col-md-4">
             <p class="text-center">
               <strong>Goal Completion</strong>
             </p>
             <div class="progress-group">
               <span class="progress-text">Water Intake</span>
               <span class="progress-number"><b>${water_goal}</b>/15</span>
               <div class="progress sm">
                 <div class="progress-bar progress-bar-aqua" style="width: ${water_goal/15 * 100}%"></div>
               </div>
             </div><!-- /.progress-group -->
             <div class="progress-group">
               <span class="progress-text">BMI</span>
               <span class="progress-number"><b>${user_bmi}</b>/24</span>
               <div class="progress sm">
                 <div class="progress-bar progress-bar-red" style="width: ${user_bmi-24/24  * 100 }%"></div>
               </div>
             </div><!-- /.progress-group -->
             <div class="progress-group">
               <span class="progress-text">Calorie burning goal</span>
               <span class="progress-number"><b>${user_burn}</b>/${burn_goal}</span>
               <div class="progress sm">
                 <div class="progress-bar progress-bar-green" style="width: 80%"></div>
               </div>
             </div><!-- /.progress-group -->
             <div class="progress-group">
               <span class="progress-text">Calorie intake goal</span>
               <span class="progress-number"><b>${user_intake}</b>/${intake_goal}</span>
               <div class="progress sm">
                 <div class="progress-bar progress-bar-yellow" style="width: 80%"></div>
               </div>
             </div><!-- /.progress-group -->
           </div><!-- /.col -->
         </div><!-- /.row -->
       </div><!-- ./box-body -->
       <div class="box-footer">
         <div class="row">
           <div class="col-sm-3 col-xs-6">
             <div class="description-block border-right">
             <c:set var="cls" value="green"/>
             <c:set var="arrow" value="up"/>
             <c:if test="${growth[1] eq 0}">
             	<c:set var="cls" value="yellow"/>
             	<c:set var="arrow" value="left"/>
             </c:if>
             <c:if test="${growth[1] lt 0}">
             	<c:set var="cls" value="red"/>
             	<c:set var="arrow" value="down"/>
             </c:if>
               <span class="description-percentage text-${cls}"><i class="fa fa-caret-${arrow}"></i> ${growth[1] < 0 ? -growth[1] : growth[1]}%</span>
               <h5 class="description-header">${growth[0]} kms</h5>
               <span class="description-text">RUNNING</span>
             </div><!-- /.description-block -->
           </div><!-- /.col -->
           <div class="col-sm-3 col-xs-6">
             <div class="description-block border-right">
             <c:set var="cls" value="green"/>
             <c:set var="arrow" value="up"/>
             <c:if test="${growth[3] eq 0}">
             	<c:set var="cls" value="yellow"/>
             	<c:set var="arrow" value="left"/>
             </c:if>
             <c:if test="${growth[3] lt 0}">
             	<c:set var="cls" value="red"/>
             	<c:set var="arrow" value="down"/>
             </c:if>
               <span class="description-percentage text-${cls}"><i class="fa fa-caret-${arrow}"></i> ${growth[3] < 0 ? -growth[3] : growth[3]}%</span>
               <h5 class="description-header">${growth[2]} kms</h5>
               <span class="description-text">WALKING</span>
             </div><!-- /.description-block -->
           </div><!-- /.col -->
           <div class="col-sm-3 col-xs-6">
             <div class="description-block border-right">
             <c:set var="cls" value="green"/>
             <c:set var="arrow" value="up"/>
             <c:if test="${growth[5] eq 0}">
             	<c:set var="cls" value="yellow"/>
             	<c:set var="arrow" value="left"/>
             </c:if>
             <c:if test="${growth[5] lt 0}">
             	<c:set var="cls" value="red"/>
             	<c:set var="arrow" value="down"/>
             </c:if>
               <span class="description-percentage text-${cls}"><i class="fa fa-caret-${arrow}"></i> ${growth[5] < 0 ? -growth[5] : growth[5]}%</span>
               <h5 class="description-header">${growth[4]} kms</h5>
               <span class="description-text">CYCLING</span>
             </div><!-- /.description-block -->
           </div><!-- /.col -->
           <div class="col-sm-3 col-xs-6">
             <div class="description-block">
             <c:set var="val" value="${growth[6]}"/>
             <%tm = get_time((int) pageContext.getAttribute("val")); %>
             <c:set var="cls" value="green"/>
             <c:set var="arrow" value="up"/>
             <c:if test="${growth[7] eq 0}">
             	<c:set var="cls" value="yellow"/>
             	<c:set var="arrow" value="left"/>
             </c:if>
             <c:if test="${growth[7] lt 0}">
             	<c:set var="cls" value="red"/>
             	<c:set var="arrow" value="down"/>
             </c:if>
               <span class="description-percentage text-${cls}"><i class="fa fa-caret-${arrow}"></i> ${growth[7] < 0 ? -growth[7] : growth[7]}%</span>
               <h5 class="description-header"><%=tm %></h5>
               <span class="description-text">WORK OUT</span>
             </div><!-- /.description-block -->
           </div>
         </div><!-- /.row -->
       </div><!-- /.box-footer -->
     </div><!-- /.box -->
   </div><!-- /.col -->
 </div><!-- /.row -->
 <script src="resources/js/chartjs.js"></script>
 <script>
  $(function () {
	var dates = [${chart[0]}];
	var str;
	for(var d in dates)
	{
		str = new Date(dates[d]);
		dates[d] = str.toString().substring(4,10);
	}
	$("#start_date").text(dates[0]);
	$("#end_date").text(dates[dates.length-1]);
	  var areaChartCanvas = $("#salesChart").get(0).getContext("2d");
      // This will get the first returned node in the jQuery collection.
      var areaChart = new Chart(areaChartCanvas);

      var areaChartData = {
        labels: dates,
        datasets: [
          {
            label: "Calories Burnt",
            fillColor: "rgba(210, 214, 222, 1)",
            strokeColor: "rgba(210, 214, 222, 1)",
            pointColor: "rgba(210, 214, 222, 1)",
            pointStrokeColor: "#c1c7d1",
            pointHighlightFill: "#fff",
            pointHighlightStroke: "rgba(220,220,220,1)",
            data: [${chart[1]}]
          },
          {
            label: "Calories Taken",
            fillColor: "rgba(60,141,188,0.9)",
            strokeColor: "rgba(60,141,188,0.8)",
            pointColor: "#3b8bba",
            pointStrokeColor: "rgba(60,141,188,1)",
            pointHighlightFill: "#fff",
            pointHighlightStroke: "rgba(60,141,188,1)",
            data: [${chart[2]}]
          }
        ]
      };

      var areaChartOptions = {
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
        //String - A legend template
        
        //Boolean - whether to maintain the starting aspect ratio or not when responsive, if set to false, will take up entire container
        maintainAspectRatio: true,
        //Boolean - whether to make the chart responsive to window resizing
        responsive: true
      };

      //Create the line chart
      areaChart.Line(areaChartData, areaChartOptions);
  });
  </script>
<%@include file="footer.jsp" %>