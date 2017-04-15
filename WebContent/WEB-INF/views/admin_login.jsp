<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html >
<head>
	<meta charset="UTF-8">
	<title>Admin Login</title>
	<base href="${pageContext.request.contextPath}/"></base>
	<link rel='stylesheet prefetch' href='http://fonts.googleapis.com/css?family=Open+Sans+Condensed:300'>
	<link rel='stylesheet prefetch' href='resources/css/font-awesome.css'>
	<link rel="stylesheet" href="resources/css/admin_style.css">
</head>

<body>
	<div class="loginform-open">
		<h2><i class="fa fa-list-alt fa-lg"></i> Admin Panel</h2>
	</div>
	<br/><br/><br/><br/>
	<form class="login-form" action="admin/signin" method="POST">
	    <label for="name">Name:</label>
	    <input type="text" name="username" id="name" required/>
	    <label for="password">Password:</label>
	    <input type="password" name="password" id="password" required/>
	    <button type="submit">Login</button>
	</form>
	<script src='resources/js/jquery.js'></script>
</body>
</html>
