<%@page import="java.io.File"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@include file="header.jsp" %>
<%@include file="sidebar.jsp" %>
<base href="${pageContext.request.contextPath}/"></base>
        <script type="text/javascript" src="resources/js/jquery.js"></script>
<style>
#wheel-tab { display: none; }
</style>
<script>
var $tabs = $('#wheel-tab li');

$('#wheel-left').on('click', function () {
    $tabs.filter('.active').prev('li').find('a[data-toggle="tab"]').tab('show');
});

$('#wheel-right').on('click', function () {
    $tabs.filter('.active').next('li').find('a[data-toggle="tab"]').tab('show');
});

</script>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %><html>
<meta name="viewport" content="width=device-width, initial-scale=1" />
<link rel="stylesheet" href="resources/css/main.css" />
<div class="page-wrap">
		
 								
   										<ul id="wheel-tab" data-tabs="tabs">
     <li class="active"><a href="#tab-1" data-toggle="tab"></a></li>
     <li><a href="#tab-2" data-toggle="tab"></a></li>
     <li><a href="#tab-3" data-toggle="tab"></a></li>
     <li><a href="#tab-4" data-toggle="tab"></a></li>
</ul>
<div class="row">
    <div class="row">
        <ul class="nav nav-tabs nav-justified tab-bar">
            <li><a href="#" id="wheel-left">PREVIOUS</a></li>
            <li><a href="#" id="wheel-right">NEXT</a></li>
        </ul>
    </div>
</div>
										<c:forEach var="k" items="${tips}">  

<div class="tab-content">
    <div class="tab-pane active" id="tab-${k.id}">
        <h2>${k.title}</h2>
        <p>${k.tip}</p>
    </div>
</div>
</c:forEach>