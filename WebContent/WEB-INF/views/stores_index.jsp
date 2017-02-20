<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@include file="header.jsp" %>
<%@include file="sidebar.jsp" %>
	<script>
		var lat = <%= session.getAttribute("latitude")%>
		var lng = <%= session.getAttribute("longitude")%>
		
		$.ajax
		({
			type: "GET",
			url: "http://www.medplusmart.com/GetStores.mart?latLong=("+lat+", "+lng+")",
			data: {},
			success: function(response)
			{
				document.write(response);
			}
		});
	</script>
<%@include file="footer.jsp" %>