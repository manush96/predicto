<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<style>
	
	#friends_div_head
	{
		background: #3164b7;
		color: #fff;
		font-size: 24px;
		padding: 10px 10px 2px 10px;
	}
	#friends_div_body
	{
		background: #fff;
		font-size: 20px;
		cursor: pointer;
	}
	.friend_row
	{
		padding: 10px;
		border-bottom: 1px solid #ccc;
		transition: all 0.2s ease;
	}
	.friend_row:hover
	{
		background: #ccc;
	}
</style>
<div style="background: #fff;">
	<div class="col-sm-12">
		<div class="col-sm-12 lr0pad" id="friends_div_head">
			<div class="col-sm-1">
				<p>#</p>
			</div>
			<div class="col-sm-4">
				<p>Name</p>
			</div>
			
		</div>
		<div class="col-sm-12" id="friends_div_body">
			<c:forEach items="${friends}" var="row" varStatus="loop">
				<div class="row friend_row">
					<div class="col-sm-1">
						<p>${loop.index + 1}</p>
					</div>
					<div class="col-sm-4">
						<p>${row.username}</p>
					</div>
					<div class="col-sm-2">
						<button class="btn btn-primary add_friend" rel="${row.id}">
							<span class="glyphicon glyphicon-plus"></span>
							 Add Friend
						</button>
					</div>
				</div>
			</c:forEach>
			<c:if test="${fn:length(friends) eq 0}">
				<h2 class="text-center">No user found!</h2>
			</c:if>
		</div>
	</div>
</div>