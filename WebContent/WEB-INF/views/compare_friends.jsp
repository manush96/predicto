<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@include file="header.jsp" %>
<%@include file="sidebar.jsp" %>
<style>
	.select2-selection
	{
		height: 48px !important;
	}
	.select2-selection__choice
	{
		background: #4286f4 !important;
		border-radius: 4px !important;
	}
</style>
<c:if test="${fn:length(friends) gt 0}">
	<div class="col-md-12">
		<div class="col-md-10">
			<select id="friends_select" class="form-control" multiple data-placeholder="Add friends to compare">
				<c:forEach items="${friends}" var="fr">
					<option value="${fr.id}">${fr.username}</option>
				</c:forEach>
			</select>
		</div>
		<div class="col-md-2" id="compare_friends">
			<button class="btn btn-success">
				<i class="fa fa-balance-scale"></i> Compare
			</button>
		</div>
	</div>
	<div class="clearfix"></div><br/>
	<hr/>
	<div class="col-md-12" id="compare_data">
		
	</div>
</c:if>
<c:if test="${fn:length(friends) eq 0}">
	<h2 class="text-center">No friends added yet! <a href="friend/add">Add now?</a></h2>
</c:if>
<script>
	$(document).ready(function()
	{
		$("#friends_select").select2();
		$("#compare_friends").click(function()
		{
			var friends = $("#friends_select").val();
			friends = friends.join();
			$.ajax
			({
				type: "POST",
				url: "friend/get_comparison",
				data: {ids: friends},
				success: function(response)
				{
					$("#compare_data").html(response);
					$(".progress-bar").each(function()
					{
						$(this).animate({width : $(this).attr('wid')+'%'},200);
					});
					$('[data-toggle="tooltip"]').tooltip();
				}
			});
		});
	});
</script>
<%@include file="footer.jsp" %>