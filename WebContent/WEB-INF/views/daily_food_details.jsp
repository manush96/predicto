<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<sql:setDataSource var="dataSource" driver="com.mysql.jdbc.Driver"
     url="jdbc:mysql://localhost/predicto"
     user="root"  password=""/>
<sql:query dataSource="${dataSource}" var="categories">
	SELECT * FROM food_category;
</sql:query>
<%@include file="header.jsp" %>
<%@include file="sidebar.jsp" %>
<style>
	.category_icon
	{
		background: #fff;
		border-radius: 10px;
		text-align: center;
	    height: 120px;
	    margin-bottom: 20px;
	    cursor: pointer;
	    box-shadow: -5px 5px 5px gray;
	    border-top: 1px solid #ccc;
	    border-right: 1px solid #ccc;
	}
	.category_icon:hover
	{
		background: #eee;
	}
</style>
<script type="text/javascript">
	var data = [];
	<c:forEach var="row" items="${categories.rows}">
		data[${row.id}] = [];
		<sql:query dataSource="${dataSource}" var="food_items">
			SELECT * FROM food_details WHERE category_id = ${row.id};
		</sql:query>
		<c:forEach var="item" items="${food_items.rows}">
			data[${row.id}]['${item.id}'] = '${item.name}';
		</c:forEach>
	</c:forEach>
	console.log(data);
</script>
<script>
	$(document).ready(function()
	{
		$(document).on("click",".category_icon",function()
		{
			var c_id = $(this).attr('rel');
			alert(c_id);
		});
	});
</script>
<div class="col-md-8 col-md-offset-2">
	<c:forEach var="row" items="${categories.rows}">
		<div class="col-md-4">
			<div class="col-md-12 category_icon" rel="${row.id}">
				<h1>${row.name}</h1>
			</div>
		</div>
	</c:forEach>
</div>
<%@include file="footer.jsp" %>