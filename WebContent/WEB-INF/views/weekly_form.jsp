<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title>El' Predicto</title>
	<meta
		content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"
		name="viewport">
	<base href="${pageContext.request.contextPath}/"></base>
	<link rel="stylesheet" type="text/css" href="resources/css/form.css" />
	<script src="resources/js/modernizr.custom.js"></script>
	<script src="resources/js/jquery.js"></script>
	<script type="text/javascript">
		var nlform;
		$(document).ready(function()
		{
			$("input").each(function()
			{
				$(this).prev().addClass($(this).attr('id'));
			});
			$(document).on("click",".cycling .nl-field-go",function(){
				val = $(".cycling").find(".nl-field-toggle").text();
				$("#cycling_time").prev().find(".nl-field-toggle").text((val*45/60));
			})
		});
	</script>
</head>
<body class="nl-blurred">
	<div class="container demo-1">
		<!-- Top Navigation -->
		<div class="main clearfix">
			<form id="nl-form" class="nl-form" action="stores/save_weekly_data">
				<p>This week's alcohol intake was  
				<input type="number" name="alcohol" value="1" placeholder="1" id="running"/>
						ML.
				<p>This week's average systolic blood pressure(Higher limit) was  
				<input type="number" name="bp_1" value="120" placeholder="120" id="running"/>mmHg.
				<p>This week's average diastolic blood pressure(lower limit) was  
				<input type="number" name="bp_2" value="80" placeholder="80" id="running"/>mmHg.		
				<p>This week's average Low density cholesterol level(Bad cholesterol) was  
				<input type="number" name="ch_1" value="80" placeholder="80" id="running"/>.	
				<p>This week's average High density cholesterol level(Good cholesterol) was  
				<input type="number" name="ch_2" value="80" placeholder="80" id="running"/>.	
				<p>This week's average blood sugar level was  
				<input type="number" name="sugar" value="80" placeholder="80" id="running"/>.
				<p>This week I smoked  
				<input type="number" name="cigs" value="12" placeholder="0" id="running"/> cigarettes.	
					<input type="hidden" name="notif_id" value="${notif_id }"/>
					<div class="nl-submit-wrap">
					<button class="nl-submit" type="submit">Update Details</button>
				</div>
				<div class="nl-overlay"></div>
			</form>
		</div>
	</div><!-- /container -->
	<script src="resources/js/nlform.js"></script>
	<script>
		nlform = new NLForm( document.getElementById( 'nl-form' ) );
	</script>
</body>
</html>