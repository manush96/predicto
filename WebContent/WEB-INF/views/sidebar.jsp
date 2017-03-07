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
	                <a ref=""><i class="fa fa-book"></i><span> Dashboard</span> <i class="fa fa-angle-left pull-right"></i></a>
	                <ul class="treeview-menu">
	                    <li><a href="user/dashboard"><i class="fa fa-home"></i> Home </a></li>
	                </ul>
	            </li>
	            <li class="treeview">
	                <a ref=""><i class="fa fa-file-text"></i><span> Reports</span> <i class="fa fa-angle-left pull-right"></i></a>
	                <ul class="treeview-menu">
	                    <li><a href="user/report"><i class="fa fa-upload"></i> Upload </a></li>
	                    <li><a href="user/report_view"><i class="fa fa-eye"></i>  View </a></li>
	                </ul>
	            </li>
	            <li class="treeview">
	                <a ref=""><i class="fa fa-hospital-o"></i><span> Medical Stores</span> <i class="fa fa-angle-left pull-right"></i></a>
	                <ul class="treeview-menu">
	                    <li><a href="stores/locate"><i class="fa fa-street-view"></i> Locate Nearby </a></li>
	                    <li><a href="stores/push"><i class="fa fa-street-view"></i> Push Daily </a></li>
	                    <li><a href="stores/push_weekly"><i class="fa fa-street-view"></i> Push Weekly </a></li>
	                </ul>
	            </li>
	            <li class="treeview">
	                <a ref=""><i class="fa fa-lightbulb-o"></i><span> Tips</span> <i class="fa fa-angle-left pull-right"></i></a>
	                <ul class="treeview-menu">
	                    <li><a href="tips/view"><i class="fa fa-quote-right"></i> View Tips </a></li>
	                </ul>
	            </li>
	            <li class="treeview">
	                <a ref=""><i class="fa fa-user"></i><span> Friends</span> <i class="fa fa-angle-left pull-right"></i></a>
	                <ul class="treeview-menu">
	                    <li><a href="friend/add"><i class="fa fa-plus"></i> Add Friends </a></li>
	                    <li><a href="friend/add"><i class="fa fa-quote-right"></i> Compare Friends </a></li>
	                    
	                </ul>
	            </li>
	        </ul>
	    </section>
	</aside>
	<div class="content-wrapper">
    	<div class="content" id="content_div" style="padding-top: 100px; min-height: 600px;">