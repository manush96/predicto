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
			<form id="nl-form" class="nl-form" action="user/save_daily_data">
				<p>Today I ran for  
				<input type="number" name="running" value="" placeholder="1" id="running"/>
					<select>
						<option value="1">Kilometer(s)</option>
						<option value="2">Mile(s)</option>
						<option value="3">Minute(s)</option>
					</select> or for
					 <p>Today I cycled for  
					<input type="number" name="cycling" id="cycling" value="" placeholder="1"/>
					Kms. or for
					 <input type="number" name="cycling_time" id="cycling_time" value="" placeholder="1"/> minutes.
						<br>
							<p>Today I walked for  
				<input type="number" name="walking" id="walking" value="" placeholder="1"/>
					Kms. or for
					 <input type="number" name="walking_time" id="walking_time" value="" placeholder="1"/> minutes.
					<br>
						<p>Today I hiked for  
				<input type="number" name="hiking" id="hiking" value="" placeholder="1"/>
					Kms. or for
					 <input type="number" name="hiking_time" id="hiking_time" value="" placeholder="1"/> minutes.
																	
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