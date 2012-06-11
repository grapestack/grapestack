<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>GRAPE Stack Sample Application</title>

<script type="text/javascript" src="/includes/javascript/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="/includes/javascript/main.js"></script>
<link rel="stylesheet" href="/includes/styles/main.css" id="mainCSS" />

<link rel="stylesheet/less" href="/includes/bootstrap/lib/bootstrap.less">

<link rel="stylesheet" href="/includes/bootstrap/bootstrap.min.responsive.css">

<link rel="stylesheet" href="/includes/bootstrap/bootstrap.css">

<script src="/includes/bootstrap/js/less.js"></script>

<!--  plugin sources -->
<script src="/includes/bootstrap/js/bootstrap.min.js"></script>


<style type="text/css">

body {
	margin-top: 60px;
}

.active {
	text-decoration: none !important;
	text-decoration: underline !important;
	font-weight: normal !important;
}

</style>

</head>
<body>

<div class="body">
<cfif isDefined("session.User") and 1 eq 2>
	<cfinclude template="/templates/menu.cfm">
</cfif>

<!--- Render The View. This is set wherever you want to render the view in your Layout. --->
<cfoutput>#renderView()#</cfoutput>

</div>

<script type="text/javascript">
	
$(function() {

// jquery ready function

$.getScript('http://connect.facebook.net/en_US/all.js', function() {
					
(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) {return;}
  js = d.createElement(s); js.id = id;
//  js.src = "//connect.facebook.net/en_US/all.js#xfbml=1";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));


 FB.init({appId: '243370505738804', status: true, cookie: true, faces: true, xfbml: true, oauth: true});
 
 	
FB.getLoginStatus(function(response) {
  if (response.status === 'connected') {
    // the user is logged in and connected to your
    // app, and response.authResponse supplies
    // the user's ID, a valid access token, a signed
    // request, and the time the access token 
    // and signed request each expire
     uid = response.authResponse.userID;
     accessToken = response.authResponse.accessToken;
     signedRequest = response.authResponse.signedRequest;
	
						if (loggedIn==true) {
                        buttonLogin();
						}
	
  } else if (response.status === 'not_authorized') {
    // the user is logged in to Facebook, 
    //but not connected to the app
  } else {
    // the user isn't even logged in to Facebook.
  }
 });
 
 
 FB.Event.subscribe('auth.login', function (response) {

if (response.status === 'connected') {
    // the user is logged in and connected to your
    // app, and response.authResponse supplies
    // the user's ID, a valid access token, a signed
    // request, and the time the access token 
    // and signed request each expire
     uid = response.authResponse.userID;
     accessToken = response.authResponse.accessToken;
     signedRequest = response.authResponse.signedRequest;
	
						if (loggedIn==true) {
                        buttonLogin();
						}
	
  }

      });
 
 FB.Event.subscribe('auth.sessionChange', function(response) {
    if (response.session) {

    } else {
      // The user has logged out, and the cookie has been cleared
    }
												   });
	 });

		   });

</script>

<div id="FB_HiddenContainer"  style="position:absolute; top:-10000px;width:0px; height:0px;" ></div>
<div id="fb-root"></div>

</body>
</html>
