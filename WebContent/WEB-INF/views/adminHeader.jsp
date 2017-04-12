<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="${pageContext.request.contextPath}/"></base>
<title>Admin</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="resources/css/admin.css">
<script src="resources/js/bootstrap.js"></script>
<style>
input[type=text] {
    width: 50%;
    padding: 12px 20px;
    margin: 8px 0;
    box-sizing: border-box;
    border: none;
    background-color:#162b4d;
    color: white;
}
div.mydiv :hover
  {
  background-color:#FF851B;
  display: block;
  margin:5px;
  padding:5px;
  }
  .closebtn {
    margin-left: 15px;
    color: white;
    font-weight: bold;
    float: right;
    font-size: 22px;
    line-height: 20px;
    cursor: pointer;
    transition: 0.3s;
}

.closebtn:hover {
    color: black;
}

.button {
  display: inline-block;
  border-radius: 4px;
  background-color: #d12767;
  border: none;
  color: #FFFFFF;
  text-align: center;
  font-size: 28px;
  padding: 20px;
  width: 200px;
  transition: all 0.5s;
  cursor: pointer;
  margin: 5px;
}

.button span {
  cursor: pointer;
  display: inline-block;
  position: relative;
  transition: 0.5s;
}

.button span:after {
  content: '\00bb';
  position: absolute;
  opacity: 0;
  top: 0;
  right: -20px;
  transition: 0.5s;
}

.button:hover span {
  padding-right: 25px;
}

.button:hover span:after {
  opacity: 1;
  right: 0;
}


</style>
	  <link rel="stylesheet" href="resources/css/components.css">
      <link rel="stylesheet" href="resources/css/responsee.css">
      <!-- CUSTOM STYLE -->  
      <link rel="stylesheet" href="resources/css/bootstrap.min.css">
      <script src="resources/js/jquery.min.js"></script>
      <script src="resources/js/bootstrap.min.js"></script>
      <link href='http://fonts.googleapis.com/css?family=Roboto:400,100,300,700&subset=latin,latin-ext' rel='stylesheet' type='text/css'>
      <link rel="stylesheet" href="resources/css/template-style.css">  
            <script type="text/javascript" src="resources/js/jquery.js"></script>  
      <script type="text/javascript" src="resources/js/modernizr.js"></script>
      <script type="text/javascript" src="resources/js/responsee.js"></script>     
</head>
<body class="size-1140" style="background-color:#ccc; color: black">
      <!-- TOP NAV WITH LOGO -->          
        <header class="margin-bottom">
         <div class="line">
            <nav>
               <div class="top-nav">
                  <p class="nav-text"></p>
                  <a class="logo" href="">            
                  Admin El<span>Predicto</span>
                  </a>            
                  <ul class="top-ul right">
                     <li>            
                        <a href="">Home</a>            
                     </li>
                  	<li>
                     <a href="">Sign out</a>
                     </li>
                     
                     <div class="social right">	           
                        <a target="_blank" href="https://www.facebook.com/">
                        <i class="icon-facebook_circle icon2x"></i>
                        </a>          
                        <a target="_blank" href="https://twitter.com/">
                        <i class="icon-twitter_circle icon2x"></i>
                        </a>  
                        <a target="_blank" href="https://www.linkedin.com/">
                        <i class="icon-linked_in_circle icon2x"></i>
                        </a> 
                        <a target="_blank" href="https://www.instagram.com/">
                        <i class="icon-instagram_circle icon2x"></i>
                        </a> 
						<a target="_blank" href="https://plus.google.com/">
                        <i class="icon-google_plus_circle icon2x"></i>
                        </a> 
                     </div>
                  </ul>
               </div>
            </nav>
         </div>
      </header>         