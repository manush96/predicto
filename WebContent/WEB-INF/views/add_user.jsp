<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<spring:url value="/resources/bootstrap.css" var="mainCss" />
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link href="${mainCss}" rel="stylesheet" />
<title>Insert title here</title>
</head>
<body>
	<% out.println((String)request.getParameter("i")); %>
	<h1 class="text-primary">Add uSer.jsp</h1>
</body>
</html>