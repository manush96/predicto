<%@page import="java.io.File"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@include file="header.jsp" %>
<%@include file="sidebar.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link href="resources/css/main.css" rel="stylesheet"/>
<link rel="stylesheet" type="text/css" href="resources/css/circle.css"/>
<style>
	.box-body img
	{
		height: 200px;
	}
</style>

<div class="col-sm-offset-3 col-sm-6">

	<h2>Your Cardiovascular health score:</h2>
	<br>
		<c:set var="color" value="green"/>
	<c:if test="${score lt 50}">
		<c:set var="color" value="orange"/>
	</c:if>
	<div style="margin-left:100px">	<div class="c100 p${chart}  big ${color}">
		<span>${score}</span>
			<div class="slice">
			    <div class="bar"></div>
			    <div class="fill"></div>
			</div>
		</div>
	</div>
</div>
<div class="clearfix"></div>
<div class="col-md-12">
	<h3 class="text-center">Which parameters affects this score?</h3>
	<div class="row">
		<div class="col-md-3">
			<div class="box box-primary collapsed-box box-solid">
				<div class="box-header with-border text-center">
					<h3 class="box-title">Body Profile</h3>
					<div class="box-tools pull-right">
						<button class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-plus"></i></button>
					</div>
				</div>
				<div class="box-body">
					<ul>
						<li>Weight: <b></b> kgs</li>
					</ul>
				</div>
			</div>
		</div>
		<div class="col-md-3">
			<div class="box box-danger collapsed-box box-solid">
				<div class="box-header with-border text-center">
					<h3 class="box-title">Body Profile</h3>
					<div class="box-tools pull-right">
						<button class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-plus"></i></button>
					</div>
				</div>
				<div class="box-body">
					<ul>
						<li>Weight: <b></b> kgs</li>
					</ul>
				</div>
			</div>
		</div>
		<div class="col-md-3">
			<div class="box box-success collapsed-box box-solid">
				<div class="box-header with-border text-center">
					<h3 class="box-title">Body Profile</h3>
					<div class="box-tools pull-right">
						<button class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-plus"></i></button>
					</div>
				</div>
				<div class="box-body">
					<ul>
						<li>Weight: <b></b> kgs</li>
					</ul>
				</div>
			</div>
		</div>
		<div class="col-md-3">
			<div class="box box-warning collapsed-box box-solid">
				<div class="box-header with-border text-center">
					<h3 class="box-title">Body Profile</h3>
					<div class="box-tools pull-right">
						<button class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-plus"></i></button>
					</div>
				</div>
				<div class="box-body">
					<ul>
						<li>Weight: <b></b> kgs</li>
						<li>Weight: <b></b> kgs</li>
						<li>Weight: <b></b> kgs</li>
					</ul>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="clearfix"></div>
<div class="col-md-12">
<ul class="timeline">
	<li>
	  <i class="fa fa-tachometer bg-blue"></i>
	  <div class="timeline-item">
	    <h2 class="timeline-header text-center"><b>Your weight</b></h2>
	    <div class="timeline-body">
	    	<div class="row">
		      	<div class="col-md-offset-1 col-md-2">
					<input type="text" min="40" max="130" class="knob" value="${w_arr[1]}" data-skin="tron" data-thickness="0.2" data-angleArc="250" data-angleOffset="-125" data-width="90" data-height="90" data-fgColor="${w_class}" data-readonly="true"/>
				</div>
				<div class="col-md-9">
					<ul>
						<li>Your weight affects nearly <b>13%</b> of your <b>Cardiovascular score</b>.</li>
						<li>For people with height <b>${ht}</b>, as of yours, ideal weight should be between <b>${w_arr[0]} kgs</b> and <b>${w_arr[2]} kgs</b>.</li>
						<c:choose>  
						    <c:when test="${w_arr[1] > w_arr[0] && w_arr[1] < w_arr[2]}">  
						       <li>Your current weight is <b>good</b>. You do not need to change your diet right now.</li>
						    </c:when>  
						    <c:when test="${w_arr[1] < w_arr[0]}">  
						        <li>Your current weight is <b class="text-warning">lower than ideal</b>. You should <b>increase</b> your daily calorie intake. <a href="user/set_goals" target="_blank">Understand here. </a></li>
						    </c:when>
						    <c:when test="${w_arr[1] > w_arr[2]}">  
						        <li>Your current weight is <b class="text-danger">higher than ideal</b>. You should <b>reduce</b> your daily calorie intake and start exercising more. <a href="user/set_goals" target="_blank">Understand here. </a></li>
						    </c:when>  
						    <c:otherwise>  
						    </c:otherwise>  
						</c:choose>
						<li>Check your weekly calorie comparison <a href="user/dashboard" target="_blank">here</a>.</li>
					</ul>
				</div>
			</div>
	    </div>
	  </div>
	</li>
	<li>
	  <i class="fa fa-stethoscope bg-blue"></i>
	  <div class="timeline-item">
	    <h2 class="timeline-header text-center"><b>Your pressure levels</b></h2>
	    <div class="timeline-body">
	    	<div class="row">
		      	<div class="col-md-2">
					<input type="text" min="60" max="140" class="knob" value="${bp_arr[0]}" data-skin="tron" data-thickness="0.2" data-angleArc="250" data-angleOffset="-125" data-width="90" data-height="90" data-fgColor="${bp_l_cls}" data-readonly="true"/>
					<h4 class="">Lower level</h4>
				</div>
				<div class="col-md-4">
					<ul>
						<li>Ideal diastolic pressure level is near <b>80 counts</b>.</li>
						<c:choose>  
						    <c:when test="${bp_arr[0] > 75 && bp_arr[0] < 85}">  
						       <li>Your diastolic bpl is <b>normal</b>.</li>
						    </c:when>  
						    <c:when test="${bp_arr[0] < 75}">  
						        <li>Your diastolic bpl is <b class="text-danger">lower than normal</b>. You should contact your doctor and take necessary medicines.</li>
						    </c:when>
						    <c:when test="${bp_arr[0] > 85}">  
						        <li>Your diastolic bpl is <b class="text-warning">higher than normal</b>. You should contact your doctor and take necessary medicines.</li>
						    </c:when>  
						    <c:otherwise>
						    </c:otherwise>  
						</c:choose>
					</ul>
				</div>
				<div class="col-md-2">
					<input type="text" min="90" max="230" class="knob" value="${bp_arr[1]}" data-skin="tron" data-thickness="0.2" data-angleArc="250" data-angleOffset="-125" data-width="90" data-height="90" data-fgColor="${bp_h_cls}" data-readonly="true"/>
					<h4 class="">Higher level</h4>
				</div>
				<div class="col-md-4">
					<ul>
						<li>Ideal systolic pressure level is near <b>120 counts</b>.</li>
						<c:choose>  
						    <c:when test="${bp_arr[1] > 115 && bp_arr[1] < 125}">  
						       <li>Your systolic bpl is <b>normal</b>.</li>
						    </c:when>  
						    <c:when test="${bp_arr[1] < 115}">  
						        <li>Your systolic bpl is <b class="text-warning">lower than normal</b>. You should contact your doctor and take necessary medicines.</li>
						    </c:when>
						    <c:when test="${bp_arr[1] > 125}">  
						        <li>Your systolic bpl is <b class="text-danger">higher than normal</b>. You should contact your doctor and take necessary medicines.</li>
						    </c:when>  
						    <c:otherwise>
						    </c:otherwise>  
						</c:choose>
					</ul>
				</div>
			</div>
	    </div>
	  </div>
	</li>
</ul>
</div>
<div class="col-sm-12">
	<div class="box box-primary">
		<div class="box-header with-border">
		
			<h3 class="box-title">Explore how we calculate calories burnt from your cycling.</h3>
		</div>
		<div class="box-body">
			<div class="col-sm-6">
				<img src="resources/img/images/cycling.png"/>
			</div>
			<div class="col-sm-6">
				<p style="text-align:justify">Cycling is mainly an aerobic activity, which means that your heart, blood vessels and lungs all get a workout. You will breathe deeper, perspire and experience increased body temperature, which will improve your overall fitness level. The health benefits of regular cycling include: increased cardiovascular fitness.We take average speed of cycling as 15.5 km/hour or 9.6 miles/hour. We convert all the units according to it. We take average calories burn every hour during cycling as 400 calories.</p>
			</div>
		</div>
	</div>
</div>

<div class="clearfix"></div>
<div class="col-sm-12">
	<div class="box box-primary">
		<div class="box-header with-border">		
			<h3 class="box-title">Explore how we calculate calories burnt from your walking.</h3>
		</div>
		<div class="box-body">
			<div class="col-sm-6">
				<img src="resources/img/images/walking.png"/>
			</div>
			<div class="col-sm-6">
				<p style="text-align:justify"> Regular walking, like most aerobic activities, is good for you because cardio-vascular exercise strengthens the heart and lungs, increasing overall fitness. Together with diet and other exercise plans, it can also help with weight loss and tone up muscles.We take average speed of walking as 5 km/hour or 3.1 miles/hour. We convert all the units according to it. We take average calories burn every hour during walking as 356 calories.</p>
			</div>
		</div>
	</div>
</div>

<div class="clearfix"></div>
<div class="col-sm-12">
	<div class="box box-primary">
		<div class="box-header with-border">
		
			<h3 class="box-title">Explore how we calculate calories burnt from your running.</h3>
		</div>
		<div class="box-body">
			<div class="col-sm-6">
				<img src="resources/img/images/running.png"/>
			</div>
			<div class="col-sm-6">
				<p style="text-align:justify">It improves your cardiovascular fitness Aerobic exercise like jogging improves your body's ability to deliver oxygen to your muscles. It also helps your muscles to become more efficient at using that oxygen.For women, running can actually help to lower your risk of breast cancer. It can also help reduce the risk of having a stroke.We take average speed of running as 8 km/hour or 5 miles/hour. We convert all the units according to it. We take average calories burn every hour during running as 610 calories.</p>
			</div>
		</div>
	</div>
</div>

<div class="clearfix"></div>
<div class="col-sm-12">
	<div class="box box-primary">
		<div class="box-header with-border">
		
			<h3 class="box-title">Explore how we calculate calories burnt from your workout.</h3>
		</div>
		<div class="box-body">
			<div class="col-sm-6">
				<img src="resources/img/images/workout.png"/>
			</div>
			<div class="col-sm-6">
				<p style="text-align:justify">In fact, exercise is one of the most important parts of keeping your body at a healthy weight. Exercise helps people lose weight and lower the risk of some diseases. Exercising to maintain a healthy weight decreases a person's risk of developing certain diseases, including type 2 diabetes and high blood pressure. We take average calories burn every hour during workout as 532 calories.</p>
			</div>
		</div>
	</div>
</div>

<div class="clearfix"></div>
<div class="col-sm-12">
	<div class="box box-primary">
		<div class="box-header with-border">
			<h3 class="box-title">Information on our water intake calculation.</h3>
		</div>
		<div class="box-body">
			<div class="col-sm-6">
				<img src="resources/img/images/water.jpg"/>
			</div>
			<div class="col-sm-6">
				<p style="text-align:justify">Every day you lose water through your breath, perspiration, urine and bowel movements. For your body to function properly, you must replenish its water supply by consuming beverages and foods that contain water.The Institute of Medicine determined that an adequate intake (AI) for men is roughly about 13 cups (3 liters) of total beverages a day. The AI for women is about 9 cups (2.2 liters) of total beverages a day.</p>
			</div>
		</div>
	</div>
</div>

<div class="clearfix"></div>
<div class="col-sm-12">
	<div class="box box-primary">
		<div class="box-header with-border">
			<h3 class="box-title">Information on our food intake calculation.</h3>
		</div>
		<div class="box-body">
			<div class="col-sm-6">
				<img src="resources/img/images/energy_intake.png"/>
			</div>
			<div class="col-sm-6">
				<p style="text-align:justify">Energy expenditure is the sum of the basal metabolic rate (the amount of energy expended while at complete rest), the thermic effect of food (TEF, the energy required to digest and absorb food) and the energy expended in physical activity.To maintain body weight, it is necessary to balance the energy derived from food with that expended in physical activity. To lose weight, energy expenditure must exceed intake, and to gain weight, energy intake must exceed expenditure. You can see and compare your recent week's food intake and energy expenditure in order to analyse your goal and be informed about yourself.</p>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript" src="resources/js/knob.js"></script>
<script type="text/javascript">
	$(function () {
	  $(".knob").each(function(){
		$(this).knob({
			min: $(this).attr('min'),
			max: $(this).attr('max'),
		    draw: function () {
	
	      // "tron" case
	      if (this.$.data('skin') == 'tron') {
	
	        var a = this.angle(this.cv)  // Angle
	                , sa = this.startAngle          // Previous start angle
	                , sat = this.startAngle         // Start angle
	                , ea                            // Previous end angle
	                , eat = sat + a                 // End angle
	                , r = true;
	
	        this.g.lineWidth = this.lineWidth;
	
	        this.o.cursor
	                && (sat = eat - 0.3)
	                && (eat = eat + 0.3);
	
	        if (this.o.displayPrevious) {
	          ea = this.startAngle + this.angle(this.value);
	          this.o.cursor
	                  && (sa = ea - 0.3)
	                  && (ea = ea + 0.3);
	          this.g.beginPath();
	          this.g.strokeStyle = this.previousColor;
	          this.g.arc(this.xy, this.xy, this.radius - this.lineWidth, sa, ea, false);
	          this.g.stroke();
	        }
	
	        this.g.beginPath();
	        this.g.strokeStyle = r ? this.o.fgColor : this.fgColor;
	        this.g.arc(this.xy, this.xy, this.radius - this.lineWidth, sat, eat, false);
	        this.g.stroke();
	
	        this.g.lineWidth = 2;
	        this.g.beginPath();
	        this.g.strokeStyle = this.o.fgColor;
	        this.g.arc(this.xy, this.xy, this.radius - this.lineWidth + 1 + this.lineWidth * 2 / 3, 0, 2 * Math.PI, false);
	        this.g.stroke();
	
	        return false;
	      }
	    }
	  });
	 });
	});
</script>