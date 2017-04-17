<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

	<aside class="main-sidebar" style="position: fixed">
	    <section class="sidebar">
	        <div class="user-panel">
	            <div class="pull-left image">
	                <img src="resources/others/dist/img/user2-160x160.jpg" class="img-circle" alt="User Image">
	            </div>
	            <div class="pull-left info">
	                <p></p>
	                <p>Dashboard</p>
	            </div>
	        </div>
	
	        <ul class="sidebar-menu">
	            <li class="active">&nbsp</li>
	            <li class="treeview">
	                <a ref=""><i class="fa fa-dashcube"></i><span> Dashboard</span> <i class="fa fa-angle-left pull-right"></i></a>
	                <ul class="treeview-menu">
	                    <li><a href="user/dashboard"><i class="fa fa-home"></i> Home </a></li>
	                    <li><a href="user/report_view"><i class="fa fa-file-text-o"></i> My Reports </a></li>
	                    <li><a href="stores/locate"><i class="fa fa-street-view"></i> Locate Nearby Stores</a></li>
	                </ul>
	            </li>
	            <li class="treeview">
	                <a ref=""><i class="fa fa-list-ol"></i><span> Diet & Activities</span> <i class="fa fa-angle-left pull-right"></i></a>
	                <ul class="treeview-menu">
	                    <li><a href="user/daily_food_details"><i class="fa fa-cutlery"></i> Food and water</a></li>
	                    <li><a href="user/set_goals"><i class="fa fa-bullseye"></i>Set Goals</a>
	                </ul>
	            </li>
	            <li class="treeview">
	                <a ref=""><i class="fa fa-plus"></i><span>Health Analysis</span> <i class="fa fa-angle-left pull-right"></i></a>
	                <ul class="treeview-menu">
	                    <li><a href="user/get_final_analysis"><i class="fa fa-info-circle"></i> My report</a></li>
	                    <li><a href="user/daily_report_view"><i class="fa fa-line-chart"></i> Daily analysis View </a></li>
	                </ul>
	            </li>
	            <li class="treeview">
	                <a ref=""><i class="fa fa-user"></i><span> Friends</span> <i class="fa fa-angle-left pull-right"></i></a>
	                <ul class="treeview-menu">
	                    <li><a href="friend/add"><i class="fa fa-plus"></i> Add Friends </a></li>
	                    <li><a href="friend/compare"><i class="fa fa-balance-scale"></i> Compare Friends </a></li>
	                    
	                </ul>
	            </li>
	             <li class="treeview">
	                <a ref=""><i class="fa fa-tint"></i><span>Blood donation</span> <i class="fa fa-angle-left pull-right"></i></a>
	                <ul class="treeview-menu">
	                    <li><a href="user/request_blood"><i class="fa fa-plus"></i> Request for blood donation </a></li>
	                    
	                </ul>
	            </li>
	        </ul>
	    </section>
	</aside>
	<div class="content-wrapper">
    	<div class="content" id="content_div" style="padding-top: 100px; min-height: 600px;">