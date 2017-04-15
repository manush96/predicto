<%@page import="java.io.File"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@include file="header.jsp" %>
<%@include file="sidebar.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link href="resources/css/main.css" rel="stylesheet"/>
<div class="col-md-6 col-md-offset-3">
	<form action="user/upload_data" method="post" enctype="multipart/form-data">
		<div class="input-group input-group-sm">
			<input type="file" name="report" class="form-control">
			<span class="input-group-btn">
				<button class="btn btn-info btn-flat" type="submit">Upload</button>
			</span>
         </div>
	</form>
</div>
<div class="clearfix"></div><hr/>
<%	
		int user_id= (Integer)session.getAttribute("user_id");
		
		String path= System.getProperty("user.dir");
		List<String> imageUrlList = new ArrayList();  
		File imageDir = new File(path+"/img/fulls/"+user_id);
		if(imageDir.exists())
		{
			for(File imageFile : imageDir.listFiles())
			{  
				String imageFileName = imageFile.getName();  
		  		imageUrlList.add(imageFileName);  
			}
		}
		request.setAttribute("imageUrlList", imageUrlList);
	 %>
	
<div class="gallery">
	<div class="content" style="margin-left:50px">
		<c:forEach var="img" items="${imageUrlList}">  
			<div class="media all people" style="margin-right:50px;margin-bottom:30x;height: 250px;">
				<a href="resources/img/fulls/<%=session.getAttribute("user_id") %>/${img}"><img src="resources/img/fulls/<%=session.getAttribute("user_id") %>/${img}" alt="" title="Image" style="height:250px; width: 100%; border: 2px solid #333"/></a>
			</div> 
		</c:forEach>
	</div>
</div>
		
<script src="resources/js/jquery.poptrox.min.js"></script>
<script src="resources/js/jquery.scrolly.min.js"></script>
<script src="resources/js/skel.min.js"></script>
<script src="resources/js/util.js"></script>
<script src="resources/js/main.js"></script>


<%@include file="footer.jsp" %>