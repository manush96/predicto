<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link href="resources/css/comparison.css" rel="stylesheet" type="text/css"/>
<c:set var="len" value="${fn:length(friends)}"></c:set>
<c:if test="${fn:length(friends) gt 0}">
	<div class="col-md-12">
		<div class="row" id="comparison_head">
			<div class="col-sm-2 head_name" id="head_hash">
				#
			</div>
			<div class="col-sm-2 head_name user_name">
				You
			</div>
			<c:forEach begin="1" end="${len-1}" varStatus="loop">
				<div class="col-sm-2 head_name">
					${friends[loop.index].username}
				</div>
			</c:forEach>
		</div>
		<div class="row" id="comparison_body">
			<div class="comparison_row col-sm-12 lr0pad" id="bmi_div">
				<div class="col-sm-2 row_title row_data">
					BMI
				</div>
				<c:forEach items="${friends}" var="fr" varStatus="loop">
					<c:choose>
						<c:when test="${fr.bmi gt 30}">
							<c:set var="cls" value="danger"/>
							<c:set var="tip" value="${fr.bmi} (Obese)"/>
						</c:when>
						<c:when test="${fr.bmi gt 25}">	
							<c:set var="cls" value="warning"/>
							<c:set var="tip" value="${fr.bmi} (Overweight)"/>
						</c:when>
						<c:when test="${fr.bmi gt 18.5}">
							<c:set var="cls" value="success"/>
							<c:set var="tip" value="${fr.bmi} (Normal)"/>
						</c:when>
						<c:otherwise>
							<c:set var="cls" value="danger"/>
							<c:set var="tip" value="${fr.bmi} (Underweight)"/>
						</c:otherwise>
					</c:choose>
					<c:if test="${loop.index eq 0}">
						<div class="col-sm-2 user_data row_data">
							<div class="progress progress_tip tip_${cls} pointer" data-toggle="tooltip" data-placement="bottom" title="${tip}" style="width: 90%;">
								<div class="progress-bar progress-bar-${cls} text-center" role="progressbar" aria-valuenow="25" aria-valuemin="1" aria-valuemax="50" wid="${fr.bmi*2}">
									${fr.bmi}
								</div>
							</div>
						</div>
					</c:if>
					<c:if test="${loop.index gt 0}">
						<div class="col-sm-2 friend_data row_data">
							<div class="progress progress_tip tip_${cls} pointer" data-toggle="tooltip" data-placement="bottom" title="${tip}" style="width: 90%;">
								<div class="progress-bar progress-bar-${cls} text-center" role="progressbar" aria-valuenow="25" aria-valuemin="1" aria-valuemax="50" wid="${fr.bmi*2}">
									${fr.bmi}
								</div>
							</div>
						</div>
					</c:if>
				</c:forEach>
			</div>
			<div class="comparison_row col-sm-12 lr0pad" id="age_div">
				<div class="col-sm-2 row_title row_data">
					Weight (Kgs)
				</div>
				<c:forEach items="${friends}" var="fr" varStatus="loop">
					<c:if test="${loop.index eq 0}">
						<div class="col-sm-2 user_data row_data">
							<p><strong>${fr.weight }</strong></p>
						</div>
					</c:if>
					<c:if test="${loop.index gt 0}">
						<div class="col-sm-2 friend_data row_data">
							<p><strong>${fr.weight }</strong></p>
						</div>
					</c:if>
				</c:forEach>
			</div>
			<div class="comparison_row col-sm-12 lr0pad" id="age_div">
				<div class="col-sm-2 row_title row_data">
					Height (cms)
				</div>
				<c:forEach items="${friends}" var="fr" varStatus="loop">
					<c:if test="${loop.index eq 0}">
						<div class="col-sm-2 user_data row_data">
							<p><strong>${fr.height }</strong></p>
						</div>
					</c:if>
					<c:if test="${loop.index gt 0}">
						<div class="col-sm-2 friend_data row_data">
							<p><strong>${fr.height }</strong></p>
						</div>
					</c:if>
				</c:forEach>
			</div>
			<div class="comparison_row col-sm-12 lr0pad" id="age_div">
				<div class="col-sm-2 row_title row_data">
					Age (Years)
				</div>
				<c:forEach items="${friends}" var="fr" varStatus="loop">
					<c:if test="${loop.index eq 0}">
						<div class="col-sm-2 user_data row_data">
							<p><strong>${fr.age }</strong></p>
						</div>
					</c:if>
					<c:if test="${loop.index gt 0}">
						<div class="col-sm-2 friend_data row_data">
							<p><strong>${fr.age }</strong></p>
						</div>
					</c:if>
				</c:forEach>
			</div>
		</div>
		<%-- <c:forEach items="${friends}" var="fr" varStatus="loop">
			<c:if test="${loop.index eq 0}">
				<h2>${fr.id}, ${fr.username}, ${fr.bmi}</h2>
			</c:if>
			<c:if test="${loop.index gt 0}">
				<p>${fr.id}, ${fr.username}, ${fr.bmi}</p>
			</c:if>
			
		</c:forEach> --%>
	</div>
</c:if>
<c:if test="${fn:length(friends) eq 0}">
	<h2 class="text-center">Invalid Comparison! <a href="friend/compare">Retry?</a></h2>
</c:if>