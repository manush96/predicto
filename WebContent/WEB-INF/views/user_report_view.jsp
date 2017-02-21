<%@page import="java.io.File"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@include file="header.jsp" %>
<%@include file="sidebar.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %><html>
<link href="resources/css/main.css" rel="stylesheet"/>
<div class="gallery">

	<%	
		String path= System.getProperty("user.dir");
		List<String> imageUrlList = new ArrayList();  
		File imageDir = new File(path+"/img/fulls");  
		for(File imageFile : imageDir.listFiles()){  
				String imageFileName = imageFile.getName();  
	  	imageUrlList.add(imageFileName);  

		}  
		request.setAttribute("imageUrlList", imageUrlList);
	 %>
		<div class="content">
			<c:forEach var="img" items="${imageUrlList}">  
				<div class="media all people">
					<a href="resources/img/fulls/${img}"><img src="resources/img/fulls/${img}" alt="" title="This right here is a caption." /> </a>
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