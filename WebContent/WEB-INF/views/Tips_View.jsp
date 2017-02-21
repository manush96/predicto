<%@page import="java.io.File"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@include file="header.jsp" %>
<%@include file="sidebar.jsp" %>
<base href="${pageContext.request.contextPath}/"></base>
<link rel="stylesheet" href="resources/css/jquery-confirm.css"/>
<script src="resources/js/jquery-confirm.js"></script>
<script>
	var titles = [];
	var tips = [];
	var index = 0;
	var colors = ['blue','green','red','orange','purple','dark'];
</script>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:forEach var="k" items="${details}">  
	<script>
		titles.push("${k.title}");
		tips.push("${k.tip}");
	</script>		
</c:forEach>
<script>
	$(document).ready(function()
	{
		show_tip();
	});
	function next_tip()
	{
		if(index == (tips.length) - 1)
			index = 0;
		else
			index++;
		show_tip();
	}
	function previous_tip()
	{
		if(index == 0)
			index = (tips.length) - 1;
		else
			index--;
		show_tip();
	}
	function show_tip()
	{
		$.confirm
		({
			title: '<h4><span class="fa fa-lightbulb-o"></span>&nbsp;&nbsp;&nbsp;<span style="font-weight: 600">' + titles[index] + "</span></h4>",
			columnClass: 'col-sm-offset-2 col-sm-10',
			backgroundDismiss: true,
			type: get_color_type(),
			content: tips[index],
			theme: 'material',
			closeIcon: true,
			buttons:
			{
				previousTip: {
					text: '<span class="fa fa-arrow-left"></span>&nbsp;Previous Tip',
		            btnClass: 'btn-default pull-left',
		            action: function(){ previous_tip(); }
		        },
		        nextTip: {
		        	text: 'Next Tip <span class="fa fa-arrow-right"></span>',
		            btnClass: 'btn-default pull-right',
		            action: function(){ next_tip(); }
		        },
			}
		});
	}
	function get_color_type()
	{
		var len = colors.length;
		var random = Math.floor((Math.random() * len));
		return colors[random];
	}
</script>
<button class="btn btn-warning" onclick="show_tip()">Replay Tips</button>
<%@include file="footer.jsp" %>