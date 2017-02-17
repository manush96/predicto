<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<a href="user/login"><h1>Login</h1></a>
	<div class="login-group homepage_admin light-wrap">
      <ul class="login_tab unstyled horizontal clearfix">
          <li class="signup-toggle toggle"><a href="/signup" data-toggle="tab">Sign Up</a></li>
          <li class="login-toggle toggle active"><a href="/login" data-toggle="tab">Log In</a></li>
      </ul>
      <div class="homepage_signup signup hide" id="signup" style="display: none;">
          <form id="legacy-signup" class="legacy-form" method="POST" __bizdiag="-1960115149" __biza="WJ__">
              <div class="homepage_signupgroup--legacy">

                  <div class="text-center alert error" style="display:none;"></div>

                  <div class="formgroup">
                          <input id="first_name" type="text" name="first_name" value="" style="width: 222px;margin-right: 6px; float: left;" placeholder="First Name" data-content="" data-toggle="tooltip" data-placement="right" data-original-title="" title="">
                          <input id="last_name" type="text" name="last_name" value="" style="width: 222px;" placeholder="Last Name" data-content="" data-toggle="tooltip" data-placement="right" data-original-title="" title="">
                  </div>
                  <div class="formgroup">
                      <i class="icon-mail"></i>
                      <input id="email" type="text" name="email" value="" placeholder="Email" data-content="" data-toggle="tooltip" data-placement="right" data-analytics="AuthPageInput" data-attr1="Email" data-attr2="Signup" data-attr3="master" data-original-title="" title="">
                  </div>
                    <div class="formgroup">
                      <i class="icon-user"></i>
                      <input id="username" type="text" name="username" value="" placeholder="Username" data-content="" data-toggle="tooltip" data-placement="right" data-analytics="AuthPageInput" data-attr1="UserName" data-attr2="Signup" data-attr3="master" data-original-title="" title="">
                    </div>
                  <div class="formgroup">
                      <i class="icon-lock"></i>
                      <input id="password" type="password" name="password" placeholder="Password" data-content="" data-toggle="tooltip" data-placement="right" data-analytics="AuthPageInput" data-attr1="Password" data-attr2="Signup" data-attr3="master" data-original-title="" title="">
                  </div>
                  <p class="text-center"><button class="btn btn-primary signup-button" name="commit" type="submit" value="request" data-analytics="SignupPassword" data-attr1="master">Create An Account</button></p>
              </div>

              <div class="homepage_signupgroup--social">
                  <p class="text-center small msB mlT psT boundT">Or connect with</p>
                  <div class="unstyled clearfix socialbuttons row text-center" id="social-signup">
                      <div class="social-btn-wrap msB span-xs-16 span-sm-4">
                          <a class="btn btn-facebook btn-social" data-analytics="SignupFacebook" data-attr1="master" data-attr2="Signup"><i class="icon-facebook"></i>Facebook</a>
                      </div>
                      <div class="social-btn-wrap msB span-xs-16 span-sm-4">
                          <a class="btn btn-google btn-social" data-analytics="SignupGoogle" data-attr1="master" data-attr2="Signup"><i class="icon-gplus"></i> Google</a>
                      </div>
                      <div class="social-btn-wrap msB span-xs-16 span-sm-4">
                          <a class="btn btn-linkedin btn-social" data-analytics="SignupLinkedIn" data-attr1="master" data-attr2="Signup"><i class="icon-linkedin"></i>LinkedIn</a>
                      </div>
                      <div class="social-btn-wrap msB span-xs-16 span-sm-4">
                          <a class="btn btn-github btn-social" data-analytics="SignupGithub" data-attr1="master" data-attr2="Signup"><i class="icon-github"></i> GitHub</a>
                      </div>
                  </div>
             </div>
             <p class="aside fnt-sz-small text-center psT">
               By signing up you agree to our <a target="_blank" href="/terms-of-service">Terms of Service</a> and <a target="_blank" href="/privacy">Privacy Policy</a>
             </p>
          </form>
      </div>

      <div class="login " id="login" style="display: block;">
          <form id="legacy-login" class="legacy-form Bizible-Exclude" method="POST">
              <div class="homepage_signupgroup--legacy">
                  <div class="text-center alert error" style="display:none;"></div>
                  <div class="formgroup">
                      <i class="icon-user"></i>
                      <input id="login" type="text" name="login" value="" placeholder="Username or email" data-analytics="AuthPageInput" data-attr1="UserName" data-attr2="Login" data-attr3="master">
                  </div>
                  <div class="formgroup">
                      <i class="icon-lock"></i>
                      <input id="password" type="password" name="password" placeholder="Password" data-analytics="AuthPageInput" data-attr1="UserName" data-attr2="Login" data-attr3="master">
                  </div>
                  <div class="clearfix msB">
                      <label class="remember pull-left psT"><input type="checkbox" id="remember_me" data-analytics="AuthPageRememberMe" data-attr1="master"> <small>Remember me</small></label>
                      <a class="cursor pull-right password-retrieve small bold msT" data-analytics="AuthForgotPassword" data-attr1="master"><small>Forgot your password?</small></a>
                  </div>
                  <p class="text-center"><button class="btn btn-primary login-button auth" name="commit" type="submit" value="request" data-analytics="LoginPassword" data-attr1="master">Log In</button></p>

              </div>
              <div class="homepage_signupgroup--social">
                  <p class="text-center small msB mlT psT boundT">Or connect with</p>
                  <div class="unstyled clearfix socialbuttons row text-center" id="social-signup">
                      <div class="social-btn-wrap msB span-xs-16 span-sm-4">
                          <a class="btn btn-facebook btn-social" data-analytics="SignupFacebook" data-attr1="master" data-attr2="Login"><i class="icon-facebook"></i>Facebook</a>
                      </div>
                      <div class="social-btn-wrap msB span-xs-16 span-sm-4">
                          <a class="btn btn-google btn-social" data-analytics="SignupGoogle" data-attr1="master" data-attr2="Login"><i class="icon-gplus"></i> Google</a>
                      </div>
                      <div class="social-btn-wrap msB span-xs-16 span-sm-4">
                          <a class="btn btn-linkedin btn-social" data-analytics="SignupLinkedIn" data-attr1="master" data-attr2="Login"><i class="icon-linkedin"></i>LinkedIn</a>
                      </div>
                      <div class="social-btn-wrap msB span-xs-16 span-sm-4">
                          <a class="btn btn-github btn-social" data-analytics="SignupGithub" data-attr1="master" data-attr2="Login"><i class="icon-github"></i> GitHub</a>
                      </div>
                  </div>
              </div>
             <p class="aside fnt-sz-small text-center psT">
               By signing up you agree to our <a target="_blank" href="/terms-of-service">Terms of Service</a> and <a target="_blank" href="/privacy">Privacy Policy</a>
             </p>
          </form>
      </div>
  </div>
	<a href="user/dashboard">Dashboard</a>
	<a href="opt/neww">OPT</a>
</body>
</html>