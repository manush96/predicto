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

<div class="col-sm-offset-3 col-sm-5">

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
				<p style="text-align:justify"> Regualr walking, like most aerobic activities, is good for you because cardio-vascular exercise strengthens the heart and lungs, increasing overall fitness. Together with diet and other exercise plans, it can also help with weight loss and tone up muscles.We take average speed of walking as 5 km/hour or 3.1 miles/hour. We convert all the units according to it. We take average calories burn every hour during walking as 356 calories.</p>
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