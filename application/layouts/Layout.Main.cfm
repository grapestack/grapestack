<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html lang="en" ng-app>
  <head>
    <meta charset="utf-8">
    <title>Sticky footer &middot; Twitter Bootstrap</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <!-- CSS -->
    <link href="/includes/assets/css/bootstrap.css" rel="stylesheet">
    
	<link rel="stylesheet" href="/includes/styles/main.css" id="mainCSS" />

    <style type="text/css">

      /* Sticky footer styles
      -------------------------------------------------- */

      html,
      body {
        height: 100%;
        /* The html and body elements cannot have any padding or margin. */
      }

      /* Wrapper for page content to push down footer */
      #wrap {
        min-height: 100%;
        height: auto !important;
        height: 100%;
        /* Negative indent footer by it's height */
        margin: 0 auto -60px;
      }

      /* Set the fixed height of the footer here */
      #push,
      #footer {
        height: 60px;
      }
      #footer {
        background-color: #f5f5f5;
      }

      /* Lastly, apply responsive CSS fixes as necessary */
      @media (max-width: 767px) {
        #footer {
          margin-left: -20px;
          margin-right: -20px;
          padding-left: 20px;
          padding-right: 20px;
        }
      }



      /* Custom page CSS
      -------------------------------------------------- */
      /* Not required for template or sticky footer method. */

      #wrap > .container {
        padding-top: 60px;
      }
      .container .credit {
        margin: 20px 0;
      }

      code {
        font-size: 80%;
      }

	.modal-body-tall {
		height: 370px;
	}

	.typeahead {
		max-height: 260px;
		max-width: 220px;
		left: 10px !important;
		top: 0px !important;
		overflow-x: hidden;
		display: none;
		position: relative;
	}
	
	#myModalBody {

	}

	#recipients {
		margin-left: 10px;
		margin-bottom: 0px;
	}
	
	#newFolder {
		left: 10px;
		top: 10px;
		position: relative;
		display: none;
	}
	
	#createNewFolder {
		left: 3px;
		top: 10px;
		position: relative;
	}
	
	#recipientsMiddle {
		margin-top: 15px !important;
	}
	
	#recipientsLeft {
		margin-top: 15px !important;
		padding-left: 10px;
	}
	
	.removeRecipient, .removeNew {
		cursor: pointer;
	}
	
	body .modal {
    /* new custom width */
    width: 800px;
    /* must be half of the width, minus scrollbar on the left (30px) */
    margin-left: -400px;
	}
	
	#sendRecipients {
		max-height: 200px;
		max-width: 200px;
		overflow-x: hidden;
		overflow-y: auto;
		top: 40px !important;
		position: relative;
		white-space:nowrap;
	}
	
	#recipientHolderText {
		white-space: normal;
	}	
	
    </style>
    <link href="/includes/assets/css/bootstrap-responsive.css" rel="stylesheet">

    <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
      <script src="/includes/assets/js/html5shiv.js"></script>
    <![endif]-->

    <!-- Fav and touch icons -->
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="/includes/assets/ico/apple-touch-icon-144-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="/includes/assets/ico/apple-touch-icon-114-precomposed.png">
      <link rel="apple-touch-icon-precomposed" sizes="72x72" href="/includes/assets/ico/apple-touch-icon-72-precomposed.png">
                    <link rel="apple-touch-icon-precomposed" href="/includes/assets/ico/apple-touch-icon-57-precomposed.png">
                                   <link rel="shortcut icon" href="/includes/assets/ico/favicon.png">
  </head>

  <body>


    <!-- Part 1: Wrap all page content here -->
    <div id="wrap">

      <!-- Fixed navbar -->
      <div class="navbar navbar-fixed-top">
        <div class="navbar-inner">
          <div class="container">
            <button type="button" class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
            </button>
            <a class="brand" href="#">grapestack.com</a>
            <div class="nav-collapse collapse">
              <ul class="nav">
                <li class="active"><a href="#">Home</a></li>
                <li><a href="#about">About</a></li>
                <li><a href="#contact">Contact</a></li>
                <li class="dropdown">
                  <a href="#" class="dropdown-toggle" data-toggle="dropdown">Dropdown <b class="caret"></b></a>
                  <ul class="dropdown-menu">
                    <li><a href="#">Action</a></li>
                    <li><a href="#">Another action</a></li>
                    <li><a href="#">Something else here</a></li>
                    <li class="divider"></li>
                    <li class="nav-header">Nav header</li>
                    <li><a href="#">Separated link</a></li>
                    <li><a href="#">One more separated link</a></li>
                  </ul>
                </li>
              </ul>
            </div><!--/.nav-collapse -->
          </div>
        </div>
      </div>

      <!-- Begin page content -->
      <div class="container">
        <div class="page-header">
          <h1>Sticky footer with fixed navbar</h1>
        </div>
        <p class="lead">
        <cfoutput>#renderView()#</cfoutput>
        </p>
		</div>
		<div id="push"></div>
      </div>

    <div id="footer">
      <div class="container">
        <p class="muted credit">Example courtesy <a href="http://martinbean.co.uk">Martin Bean</a> and <a href="http://ryanfait.com/sticky-footer/">Ryan Fait</a>.</p>
      </div>
    </div>



    <!-- Le javascript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="/includes/assets/js/jquery.js"></script>
    <script src="/includes/assets/js/bootstrap.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.0.6/angular.min.js"></script>
	<script type="text/javascript" src="/includes/javascript/main.js"></script>



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


 FB.init({appId: '0000000000', status: true, cookie: true, faces: true, xfbml: true, oauth: true});
 
 	
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