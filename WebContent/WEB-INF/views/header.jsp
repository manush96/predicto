<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*,com.predicto.controller.*"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title>El' Predicto</title>
	<meta
		content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"
		name="viewport">
	<base href="${pageContext.request.contextPath}/"></base>
	<link rel="shortcut icon" type="image/png" href="resources/img/favicon.png"/>
	<link rel="stylesheet" type="text/css" href="resources/others/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="resources/css/font-awesome.css">
	<link rel="stylesheet" type="text/css" href="resources/css/ionicons.css">
	<link rel="stylesheet" type="text/css" href="resources/others/dist/css/AdminLTE.min.css">
	<link rel="stylesheet" type="text/css" href="resources/others/dist/css/skins/_all-skins.min.css">
	<link rel="stylesheet" type="text/css" href="resources/css/stylesheet.css">
	<link rel="stylesheet" type="text/css" href="resources/css/select2.css">
	<link rel="stylesheet" type="text/css" href="resources/css/jquery-confirm.css">
	<link rel="stylesheet" type="text/css" href="resources/css/dropzone.css">
	<link rel="stylesheet" type="text/css" href="resources/js/square/purple.css">
	
	<script type="text/javascript" src="resources/others/plugins/jQuery/jQuery-2.1.4.min.js"></script>
	<script type="text/javascript" src="resources/others/bootstrap/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="resources/js/jquery-confirm.js"></script>
	<script type="text/javascript" src="resources/js/icheck.js"></script>
	<script type="text/javascript" src="resources/js/jquery.validate.js"></script>
	<script type="text/javascript" src="resources/js/dropzone.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			$('.dropdown-toggle').dropdown();
			$("#tips_btn").click(function(){ $(this).find(".label").fadeOut("slow");	});
			$("#notif_btn").click(function(){ set_notif_read();$(this).find(".label").fadeOut("slow");	});
		});
		function set_notif_read()
		{
			$.ajax
			({
				type: "POST",
				url: "user/set_notif_read",
				data: {},
				success: function(response)
				{
					
				}
			});
		}
	</script>
	<script type="text/javascript" src="resources/js/select2.js"></script>
	<script type="text/javascript" src="resources/js/general.js"></script>
	<script type="text/javascript" src="resources/others/plugins/slimScroll/jquery.slimscroll.min.js"></script>
	<script type="text/javascript" src="resources/others/dist/js/app.min.js"></script>
</head>
<% String name = (String) session.getAttribute("username"); %>
<c:set var="tips_s" scope="application" value="<%= tips_controller.get_tips(session) %>"/>
<sql:setDataSource var="dataSource" driver="com.mysql.jdbc.Driver"
     url="jdbc:mysql://localhost/predicto"
     user="root"  password=""/>
<sql:query dataSource="${dataSource}" var="tips">
	SELECT * FROM tips WHERE id IN (${tips_s});
</sql:query>
<c:set var="tips_cnt" scope="application" value="${tips.rowCount}"/>
<sql:query dataSource="${dataSource}" var="daily">
	SELECT * FROM notifications WHERE user_id = ${sessionScope.user_id} AND type = 0 ORDER BY status;
</sql:query>
<sql:query dataSource="${dataSource}" var="weekly">
	SELECT * FROM notifications WHERE user_id = ${sessionScope.user_id} AND type = 1 ORDER BY status;
</sql:query>
<sql:query dataSource="${dataSource}" var="notifs">
	SELECT COUNT(*) AS cnt FROM notifications WHERE user_id = ${sessionScope.user_id} AND status = 0;
</sql:query>
<c:set var="notif_cnt" scope="application" value="${notifs.rowsByIndex[0][0]}"/>
<sql:query dataSource="${dataSource}" var="friend_requests">
	SELECT username, user_id
		FROM friends 
		LEFT JOIN user on user.id = friends.user_id
		WHERE friends.status = '0'  
		AND friend_id='${sessionScope.user_id}';
</sql:query>
<body class="skin-blue sidebar-mini">
	<div id="wrapper">
		<header class="main-header"  style="position: fixed; width: 100%">
			<a href="javascript:void(0)" class="logo"> <span
				class="logo-mini"><b>Pr</b></span> <span class="logo-lg"><b>Predicto</b></span>
			</a>
			<nav class="navbar navbar-static-top" role="navigation">
				<a href="#" class="sidebar-toggle" data-toggle="offcanvas"
					role="button"> <span class="sr-only">Toggle navigation</span>
				</a>
				<div class="navbar-custom-menu">
					<ul class="nav navbar-nav">
						<!-- Messages: style can be found in dropdown.less-->
						<li class="dropdown messages-menu">
								<a href="#" id="tips_btn"
									class="dropdown-toggle" data-toggle="dropdown"> <i
										class="fa fa-lightbulb-o"></i>
										<c:if test="${tips_cnt > 0}">
											<span class="label label-success">${tips_cnt}</span>
										</c:if>
								</a>
							<ul class="dropdown-menu">
								<c:if test="${tips_cnt > 0}">
								   <li class="header">You have ${tips_cnt} new tips</li>
								</c:if>
								<li>
									<!-- inner menu: contains the actual data -->
									<ul class="menu">
										<c:forEach var="row" items="${tips.rows}">
										<li>
											<!-- start message --> <a href="#">
												<div class="pull-left">
													<i class="fa fa-lightbulb-o"></i>
												</div>
												<h4>
													${row.tip_title}
												</h4>
										</a>
										</li>
										</c:forEach>
										<!-- end message -->
									</ul>
								</li>
								<li class="footer"><a href="tips/view">See All tips.</a></li>
							</ul></li>
						<!-- Notifications: style can be found in dropdown.less -->
						<li class="dropdown notifications-menu">
								<a href="#" id="notif_btn"
									class="dropdown-toggle" data-toggle="dropdown"> <i
										class="fa fa-bell-o"></i>
										<c:if test="${notif_cnt > 0}">
											<span class="label label-warning">${notif_cnt}</span>
										</c:if>
								</a>
							<ul class="dropdown-menu">
								<c:if test="${notif_cnt > 0}">
									<li class="header">You have ${notif_cnt} new notification(s).</li>
								</c:if>
								<li>
									<!-- inner menu: contains the actual data -->
									<ul class="menu">
										<c:forEach var="row" items="${daily.rows}">
											<li>
												<a href="user/daily_data?id=${row.id}"> <i class="fa fa-users text-aqua"></i>
													Update your daily progress!
												</a>
											</li>
										</c:forEach>
										<c:forEach var="row" items="${weekly.rows}">
											<li>
												<a href="user/weekly_data?id=${row.id}"> <i class="fa fa-users text-aqua"></i>
													<%=new java.util.Date()%>
												</a>
											</li>
										</c:forEach>
									</ul>
								</li>
							</ul></li>
						<!-- Tasks: style can be found in dropdown.less -->
						<li class="dropdown tasks-menu"><a href="#"
							class="dropdown-toggle" data-toggle="dropdown"> <i
								class="fa fa-user-plus"></i> <span class="label label-danger">9</span>
						</a>
							<ul class="dropdown-menu">
								<li class="header">You have new friend requests.</li>
								<li>
									<!-- inner menu: contains the actual data -->
									<ul class="menu">
										<c:forEach var="row" items="${friend_requests.rows}">
											<li>
												<a>	
													<button class="btn btn-info round confirm_friend" rel="${row.user_id}">
														<i class="fa fa-plus"></i>
													</button> ${row.username}
													<span class="text-primary">
														
													</span>
												</a>													
											</li>
										</c:forEach>
										<li>
											<!-- Task item --> <a href="#">
												<h3>
													Make beautiful transitions <small class="pull-right">80%</small>
												</h3>
												<div class="progress xs">
													<div class="progress-bar progress-bar-yellow"
														style="width: 80%" role="progressbar" aria-valuenow="20"
														aria-valuemin="0" aria-valuemax="100">
														<span class="sr-only">80% Complete</span>
													</div>
												</div>
										</a>
										</li>
										<!-- end task item -->
									</ul>
								</li>
								<li class="footer"><a href="#">View all tasks</a></li>
							</ul></li>
						<!-- User Account: style can be found in dropdown.less -->
						<li class="dropdown user user-menu"><a href="#"
							class="dropdown-toggle" data-toggle="dropdown"> <img
								src="resources/others/dist/img/user2-160x160.jpg"
								class="user-image" alt="User Image"> <span
								class="hidden-xs"><%= name %></span>
						</a>
							<ul class="dropdown-menu">
								<!-- User image -->
								<li class="user-header"><img
									src="resources/others/dist/img/user2-160x160.jpg"
									class="img-circle" alt="User Image">
									<p>
										<%= name %>
									</p>
								</li>
								<!-- Menu Footer-->
								<li class="user-footer">
									<div class="pull-left">
										<a href="#" class="btn btn-default btn-flat">Profile</a>
									</div>
									<div class="pull-right">
										<a href="user/logout" class="btn btn-default btn-flat">Sign out</a>
									</div>
								</li>
							</ul>
						</li>
					</ul>
				</div>
			</nav>
		</header>