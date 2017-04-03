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
			$("#tips_btn").click(function(){ $(this).find(".label").fadeOut("slow");});
			$("#notif_btn").click(function(){ set_notif_read();$(this).find(".label").fadeOut("slow");	});
			$("#friend_req_btn").click(function(){ $(this).find(".label").fadeOut("slow");	});
			setTimeout(function()
				{
					$(".menu").css("height","auto");
					$(".menu").parent().css("height","auto");
				},100);
			
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
	SELECT * FROM notifications WHERE user_id = ${sessionScope.user_id} AND type = 0 AND DATE(pushed_when) = CURDATE() ORDER BY status;
</sql:query>
<sql:query dataSource="${dataSource}" var="weekly">
	SELECT * FROM notifications WHERE user_id = ${sessionScope.user_id} AND type = 1 AND DATE(pushed_when) = CURDATE() ORDER BY status;
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
<sql:query dataSource="${dataSource}" var="f_r_cnt">
	SELECT COUNT(username) as cnt
		FROM friends 
		LEFT JOIN user on user.id = friends.user_id
		WHERE friends.status = '0'  
		AND friend_id='${sessionScope.user_id}';
</sql:query>
<c:set var="friend_req_cnt" scope="application" value="${f_r_cnt.rowsByIndex[0][0]}"/>
<script>
	var titles = [];
	var tips = [];
	var index = 0;
	var colors = ['blue','green','red','orange','purple','dark'];
</script>
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
										<%
											int lp = -1;
										%>
										<c:forEach var="row" items="${tips.rows}">
											<c:set var="temp" value="${row.tip}"/>
											<%
												lp++;
												String tip = (String)pageContext.getAttribute("temp");
												tip = tip.replace("\n", "<br/>").replace("\"", "\\\"").replace("'", "\'").replace("\r", "");
											%>
										<script>
											titles.push("${row.tip_title}");
											tips.push("<%=tip%>");
										</script>	
										<li>
											<!-- start message --> <a href="javascript:show_tip(<%=lp%>)">
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
								<li class="footer"><a href="javascript:show_tip()">See All tips.</a></li>
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
													Update your <b>daily</b> progress!
												</a>
											</li>
										</c:forEach>
										<c:forEach var="row" items="${weekly.rows}">
											<li>
												<a href="user/weekly_data?id=${row.id}"> <i class="fa fa-users text-aqua"></i>
													Update your <b>weekly</b> progress!
												</a>
											</li>
										</c:forEach>
									</ul>
								</li>
							</ul></li>
						<!-- Tasks: style can be found in dropdown.less -->
						<li class="dropdown tasks-menu"><a href="#" id="friend_req_btn"
							class="dropdown-toggle" data-toggle="dropdown"> <i
								class="fa fa-user-plus"></i> 
								<c:if test="${friend_req_cnt > 0}">
									<span class="label label-danger">${friend_req_cnt}</span>
								</c:if>
						</a>
							<ul class="dropdown-menu">
								<c:if test="${friend_req_cnt > 0}">
									<li class="header">You have ${friend_req_cnt} new friend request(s).</li>
								</c:if>
								<li>
									<!-- inner menu: contains the actual data -->
									<ul class="menu">
										<c:forEach var="row" items="${friend_requests.rows}">
											<div class="confirm_friend_li">
												<div class="col-sm-12">
													<p><strong>${row.username}</strong> sent you a friend request.</p>
												</div>
												<div class="col-sm-12">
													<div class="col-sm-5">
														<button class="btn btn-primary confirm_friend" rel="${row.user_id}">
															<i class="fa fa-check"></i> Accept
														</button>
													</div>
													<div class="col-sm-2"></div>
													<div class="col-sm-5">
														<button class="btn btn-danger decline_friend" rel="${row.user_id}">
															<i class="fa fa-times"></i> Reject
														</button>
													</div>
												</div>
											</div>
										</c:forEach>
									</ul>
								</li>
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
		<script type="text/javascript">
			function next_tip()
			{
				index++;
				show_tip();
			}
			function previous_tip()
			{
				index--;
				show_tip();
			}
			function show_tip(ind=9999)
			{
				if(ind != 9999)
					index = ind;
				var data = {
						title: '<h4><span class="fa fa-lightbulb-o"></span>&nbsp;&nbsp;&nbsp;<span style="font-weight: 600">' + titles[index] + "</span></h4>",
						columnClass: 'col-sm-offset-2 col-sm-10',
						backgroundDismiss: true,
						type: get_color_type(),
						content: tips[index],
						theme: 'material',
						closeIcon: true,
						buttons:
						{
							previousTip: {
								text: '<span class="fa fa-arrow-left"></span>&nbsp;Previous Tip',
					            btnClass: 'btn-default pull-left',
					            action: function(){ previous_tip(); }
					        },
					        nextTip: {
					        	text: 'Next Tip <span class="fa fa-arrow-right"></span>',
					            btnClass: 'btn-default pull-right',
					            action: function(){ next_tip(); }
					        },
						}
					}
				if(index == (tips.length) - 1)
					delete data.buttons.nextTip;
				if(index == 0)
					delete data.buttons.previousTip;
				$.confirm
				(data);
			}
			function get_color_type()
			{
				var len = colors.length;
				var random = Math.floor((Math.random() * len));
				return colors[random];
			}
		</script>