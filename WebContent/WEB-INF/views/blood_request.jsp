<%@page import="java.io.File"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@include file="header.jsp" %>
<%@include file="sidebar.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="resources/css/morris.css"/>
<link href="resources/css/main.css" rel="stylesheet"/>
	<div class="col-md-offset-3 col-md-6">
		<div class="box box-danger">
			<div class="box-header with-border text-center">
				<h3 class="box-title">
					Contact Info
				</h3>
			</div>
			<div class="box-body">
				<p><b>Contact: </b>${blood1.contact}</p>
				<p> This person is in need of ${blood1.type} blood.</p>
			</div>
		</div>
	</div>
</body>
</html>