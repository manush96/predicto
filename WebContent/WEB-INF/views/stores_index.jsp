<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@include file="header.jsp" %>
<%@include file="sidebar.jsp" %>
	<script src="http://maps.googleapis.com/maps/api/js?key=AIzaSyBBRNM1pWrb94tlegwrj9LbZQcGGmotNl4"></script>
	<script type="text/javascript">
		var lat = [${ lats}];
		var long = [${ lngs}];
		var names = [${ names}];
		var contacts = [${ contacts}];
		var addresses = [${ addresses}];
	</script>
	<script type="text/javascript" src="resources/js/map.js"></script>
	<div class="col-sm-12">
		<div  id="googleMap" style="width:100%;height:550px;"></div>
	</div>
<%@include file="footer.jsp" %>