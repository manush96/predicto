<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div style="background: #fff;">
	<table class="table table-bordered table-hover table-responsive table-striped">
		<thead>
			<tr>
				<th>#</th>
				<th>Name</th>
				<th>Add Friend</th>
			<tr>
		</thead>
		<c:forEach items="${friends}" var="row" varStatus="loop">
			<tr>
				<td>${loop.index + 1}</td>
				<td>${row.username}</td>
				<td>
					<button class="btn btn-info add_friend" rel="${row.id}">
						<span class="glyphicon glyphicon-plus"></span>
						 Add Friend
					</button>
				</td>
			</tr>
		</c:forEach>
	</table>
</div>