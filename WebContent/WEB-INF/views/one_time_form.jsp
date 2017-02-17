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
</head>
<body class="nl-blurred">
	<div class="container demo-1">
		<!-- Top Navigation -->
		<div class="main clearfix">
			<form id="nl-form" class="nl-form" action="user/save_one_time_data">
				<p>I am 
					<select name="gender">
						<option value="1" selected>Mr.</option>
						<option value="0">Miss</option>
					</select>
					 Vismay and I am  
					<input type="number" name="age" value="30" placeholder="30"/>
					years old.
				</p>
				<p>My height is 
					<input type="number" name="height" value="150" placeholder="150"/>
					CMs and I weigh 
					<input type="number" name="weight" value="70" placeholder="70"/> KGs.
				</p>
				<p>I am 
					<select name="diabetic">
						<option value="1" selected>a diabetic</option>
						<option value="0">not a diabetic</option>
					</select>
				</p>
				<div class="nl-submit-wrap">
					<button class="nl-submit" type="submit">Continue to Predicto</button>
				</div>
				<div class="nl-overlay"></div>
			</form>
		</div>
	</div><!-- /container -->
	<script src="resources/js/nlform.js"></script>
	<script>
		var nlform = new NLForm( document.getElementById( 'nl-form' ) );
	</script>
</body>
</html>