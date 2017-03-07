<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="header.jsp" %>
<%@include file="sidebar.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script src="resources/js/add_friend.js"></script>
<div class="col-sm-12">
	<div class="col-sm-10">
		<div class="form-group">
			<input id="user_search" type="text" class="form-control" placeholder="Search here..."/>
		</div>
	</div>
	<div class="col-sm-2">
		<button class="btn btn-primary" id="search_friends">
			<span class="glyphicon glyphicon-search"></span> Search
		</button>
	</div>
</div>
<hr/>
<div class="col-sm-12" id="friend_div"></div>
<%@include file="footer.jsp" %>