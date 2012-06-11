<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>GRAPE Stack Sample Application</title>

<script type="text/javascript" src="/includes/javascript/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="/includes/javascript/underscore-min.js"></script>
<script type="text/javascript" src="/includes/javascript/backbone-min.js"></script>
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

<div class="navbar navbar-fixed-top">
      <div class="navbar-inner">
        <div class="container-fluid">
          <a class="brand" href="#">GRAPE Stack Sample Application</a>
              <div class="nav-collapse">
                  <ul class="nav">
        
        <cfinclude template="/templates/menuItems.cfm">
        
        <cfoutput>
                
                <cfif #security('admin')#>
                <li class=" #defaults['admin']#" data-link="/admin">
                    <a href="/admin">Admin</a>
                </li>
                </cfif>
                                            
                <li class="" data-link="/">
                    <a href="/">Home</a>
                </li>
        
        </cfoutput>
        
                  </ul>
              </div>
          <p class="navbar-text pull-right"><cfif isDefined("session.User")><span class="lightGrey">Logged in as</span> <span class="menuHighlight heavy"><cfoutput>#session.User.getEmail()#</cfoutput></span> | <a href="/logout">Log out</a></cfif></p>
        </div>
      </div>
    </div>

<div class="container-fluid">
      <div class="row-fluid">
        <div class="span2">
          <div class="well sidebar-nav">
			<cfinclude template="/templates/sideMenu.cfm">
          </div><!--/.well -->        
        </div><!--/span-->
        <div class="span9">
          <div class="hero-unit">
            
			<cfoutput>#renderView()#</cfoutput>
            
          </div><!--/row-->
        </div><!--/span-->
      </div><!--/row-->

      <hr>

      <footer>
        <p>&copy; GRAPE Stack <cfoutput>#dateFormat(now(), "yyyy")#</cfoutput></p>
      </footer>
</div>

</body>
</html>
