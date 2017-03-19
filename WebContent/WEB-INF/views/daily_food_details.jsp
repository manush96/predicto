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
	#selected_items
	{
		margin-top: 20px;
		margin-bottom: 20px;
		background: #fff;
		padding-top: 15px;
		padding-bottom: 15px;
	}
	#selected_items .selected_item
	{
		padding: 6px 4px;
	}
	#selected_items .selected_item h4
	{
		font-size: 23px !important;
		font-weight: 550 !important;
	}
	#selected_items .selected_item .btn
	{
		margin-top: 4px;
	}
	#selected_items .selected_item:nth-child(odd)
	{
		background: #cfe3e8;
	}
</style>
<script type="text/javascript">
	var data = [];
	var items = [];
	<c:forEach var="row" items="${categories.rows}">
		data[${row.id}] = [];
		<sql:query dataSource="${dataSource}" var="food_items">
			SELECT * FROM food_details WHERE category_id = ${row.id};
		</sql:query>
		<c:forEach var="item" items="${food_items.rows}">
			data[${row.id}]['${item.id}'] = '${item.name}';
		</c:forEach>
	</c:forEach>
</script>
<script>
	$(document).ready(function()
	{
		$(document).on("click",".category_icon",function()
		{
			var c_id = $(this).attr('rel');
			$("#select_items").html('');
		
			for(var i in data[c_id])
				$("#select_items").append('<option value="'+i+'">'+data[c_id][i]+'</option>');
			$("#select_categories").hide();
			$("#select_items").select2();
			$(".select2").css('width','100%');
			$("#items_div").fadeIn("slow");
		});
		$(document).on("click",".remove_item",function()
		{
			remove_item($(this).attr('rel'));
		});
	});
	function add_food_item()
	{
		var val = $("#select_items").val();
		var txt = $("#select_items option:selected").text();
		items[val] = txt;
		fill_table();
	}
	function remove_item(id)
	{
		items.splice(id, 1);
		fill_table();
	}
	function get_html(no,txt,val)
	{
		var clone = $("#get_html_div").find(".selected_item").clone();
		clone.find(".index").text(no);
		clone.find(".item_text").text(txt);
		clone.find(".remove_item").attr('rel',val);
		return clone[0].outerHTML;
	}
	function go_back()
	{
		$("#items_div").hide();
		$("#select_categories").show();
	}
	function fill_table()
	{
		var len = Object.keys(items).length;
		$("#item_vals").val(Object.keys(items));
		if(len > 0)
		{
			$("#save_inserted").show();
			$("#selected_items").html("");
			var cnt = 1;
			for(var i in items)
			{
				var val = i;
				var txt = items[i];
				$("#selected_items").append(get_html(cnt,txt,val));
				cnt++;
			}
			go_back();
		}
		else
		{
			$("#save_inserted").hide();
			$("#selected_items").html('<h4 class="no_items">No items selected!</h4>');
		}
	}
</script>
<div style="min-height: 300px">
<div class="col-md-8 col-md-offset-2" id="select_categories">
	<c:forEach var="row" items="${categories.rows}">
		<div class="col-md-4">
			<div class="col-md-12 category_icon" rel="${row.id}">
				<h1>${row.name}</h1>
			</div>
		</div>
	</c:forEach>
</div>
<div class="clearfix"></div><br/>
<div class="col-md-8 col-md-offset-2" id="items_div" style="display: none">
	<button class="btn btn-danger" onclick="go_back()">
		&lt;-- Back
	</button>
	<div class="clearfix"></div><br/><br/>
	<select class="form-control" id="select_items">
		
	</select>
	<div class="clearfix"></div><br/><br/>
	<div class="col-md-12 lr0pad text-center">
		<button class="btn btn-success" style="float: none" onclick="add_food_item()">
				+ Add
		</button>
	</div>
</div>
</div>
<div class="clearfix"></div><br/><hr/>
<h2 class="text-center"><u>Selected Items</u></h2>
<div>
	<form action="">
		<input type="hidden" name="items" id="item_vals"/>
		<div class="col-md-12" id="selected_items">
			<h4 class="no_items">No items selected!</h4>
		</div>
		<div class="col-md-offset-1 col-md-2">
			<button id="save_inserted" class="btn btn-info" style="display: none">
				<h4>
					<span class="glyphicon glyphicon-floppy-saved"></span>
					Save items
				</h4>
			</button>
		</div>
	</form>
</div>
<div id="get_html_div" style="display: none">
	<div class="selected_item col-md-12">
		<div class="col-md-1"></div>
		<div class="col-md-1">
			<h4 class="index"></h4>
		</div>
		<div class="col-md-6">
			<h4 class="item_text"></h4>
		</div>
		<div class="col-md-2">
			<button type="button" class="btn btn-danger remove_item" rel="">
				<span class="glyphicon glyphicon-trash"></span>
			</button>
		</div>
		<div class="clearfix"></div>
	</div>
</div>
<%@include file="footer.jsp" %>