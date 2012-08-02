component{

	function login(event,rc,prc){
		// set a view for rendering
		event.setLayout("Layout.Main");
		event.setView("login");
        
    	structClear(session);
        
        if (NOT isDefined("rc.loginResults")) {
			rc.loginResults = ORMExecuteQuery("from user where email = '#rc.email#' and password = '#rc.password#'");
        }
                
        if (arrayLen(rc.loginResults)) {
        	rc.returnValue = true;

            rc.roles = [];
            
            for ( var item in rc.loginResults[1].getRoles() ) {
            	rc.roles[arrayLen(rc.roles)+1] = item;
            }                        
            
            if (isDefined("rc.fbToken")) {
                rc.loginResults[1].setFacebookToken(rc.fbToken);
                EntitySave(rc.loginResults[1]);
                ORMFlush();                              
            }
            
            session.User = createObject("component", "models.user");
            session.User.setUserid(rc.loginResults[1].getUserid());
            session.User.setEmail(rc.loginResults[1].getEmail());            
            session.User.setRoles(rc.roles);
                        
			if (NOT Event.isProxyRequest() and isDefined("rc.fbToken")) {
            	//setNextEvent(uri='/');
				event.setView("home");
                event.setLayout("Layout.FacebookAuth");
            }

        } else {
        	rc.returnValue = false;
        }
        
		if (Event.isProxyRequest()) {
    	    return rc.returnValue;
		}
        
	}	

	function logout(event,rc,prc){
    	structClear(session);
        
        if (NOT Event.isProxyRequest()) {
        	setNextEvent(uri='/');
        }
        
		if (Event.isProxyRequest()) {
    	    return true;
		}
        
	}
    
    function facebook(event,rc,prc) {
    
         if (NOT isDefined("rc.loginResults")) {
			rc.loginResults = ORMExecuteQuery("from user where facebookID = #rc.facebookID#");
        }
        
        if (arrayLen(rc.loginResults)) {
        	runEvent("user.login");
        } else {
            event.setLayout("Layout.Main");
            runEvent("user.create");
        }
    	
    }
    
	function create(event,rc,prc){
		// set a view for rendering
		event.setLayout("Layout.Main");
		event.setView("create");
        
    	structClear(session);
        
        session.User = EntityNew('user');
        
        if (isDefined("rc.facebookID")) {
	        session.User.setFacebookID(rc.facebookID);
	        session.User.setUsername(rc.facebookID);
	        session.User.setDisplayname(rc.facebookID);
	        session.User.setEmail(rc.fbEmail);
	        session.User.setFacebookToken(rc.fbToken);
        } else {
            session.User.setEmail(rc.email);
            session.User.setUsername(rc.email);
            session.User.setDisplayname(rc.email);
            session.User.setPassword(rc.password);
        }
        
        rc.roles = EntityLoad("role", 2);
        session.User.setRoles(rc.roles);
        EntitySave(session.User);
		
        if (isDefined("rc.facebookID")) {
            event.setLayout("Layout.FacebookAuth");
        } else {
	        setNextEvent(uri='/');
        }
        
		if (Event.isProxyRequest()) {
    	    return rc.returnValue;
		}
        
	}	

}