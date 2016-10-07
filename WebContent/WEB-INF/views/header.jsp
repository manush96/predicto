<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<title>El' Predicto</title>
		<meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
		<base href="${pageContext.request.contextPath}/"></base>
		<link rel="stylesheet" type="text/css" href="resources/others/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="resources/css/font-awesome.css">
        <link rel="stylesheet" type="text/css" href="resources/css/ionicons.css">
        <link rel="stylesheet" type="text/css" href="resources/others/dist/css/AdminLTE.min.css">
        <link rel="stylesheet" type="text/css" href="resources/others/dist/css/skins/_all-skins.min.css">
        <link rel="stylesheet" type="text/css" href="resources/css/stylesheet.css">
        <link rel="stylesheet" type="text/css" href="resources/css/select2.css">
        <link rel="stylesheet" type="text/css" href="resources/css/jquery-confirm.css">
        <link rel="stylesheet" type="text/css" href="resources/js/square/purple.css">
        
        <script type="text/javascript" src="resources/others/plugins/jQuery/jQuery-2.1.4.min.js"></script>
        <script type="text/javascript" src="resources/others/bootstrap/js/bootstrap.min.js"></script>
        <script type="text/javascript" src="resources/js/jquery-confirm.js"></script>
        <script type="text/javascript" src="resources/js/icheck.js"></script>
        <script type="text/javascript" src="resources/js/jquery.validate.js"></script>
        <script type="text/javascript">
        $(document).ready(function()
        {
            $('.dropdown-toggle').dropdown();
        });
        </script>
        <script type="text/javascript" src="resources/js/select2.js"></script>
        <script type="text/javascript" src="resources/js/general.js"></script>
        <!-- Slimscroll 
        <script type="text/javascript" src="resources/others/plugins/slimScroll/jquery.slimscroll.min.js"></script>-->
        <script type="text/javascript" src="resources/others/dist/js/app.min.js"></script>
	</head>
	<body class="skin-blue sidebar-mini">
		<div id="wrapper">
			<div class="header">
				<header class="main-header">
					<a href="javascript:void(0)" class="logo">
						<span class="logo-mini"><b>Pr</b></span>
						<span class="logo-lg"><b>Predicto</b></span>
					</a>
					<nav class="navbar navbar-static-top" role="navigation">
						<a href="#" class="sidebar-toggle" data-toggle="offcanvas" role="button">
							<span class="sr-only">Toggle navigation</span>
						</a>
						<div id="title_div">
							<span id="link_title">Header</span>
							<div id="logout_link" class="pull-right">
								<a href="user/logout/">
									<span class="glyphicon glyphicon-off"></span>
									<span class="logout_text"> Logout</span>
								</a>
							</div>
						</div>    
					</nav>
				</header>
			</div>		