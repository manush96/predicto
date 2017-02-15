<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@include file="header.jsp" %>
<%@include file="sidebar.jsp" %>

<form action="user/upload_data" method="post" enctype="multipart/form-data">
Choose file:
<input type="file" name="report"/>
<br>
<input type="submit">
</form>



<%@include file="footer.jsp" %>