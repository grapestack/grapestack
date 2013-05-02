<div class="container-fluid">

<div class="body-content">

      <div class="row-fluid">
        <div class="span5">
          <div class="well">
			
<cfoutput>

        <form method="POST" action="/user/create" class="fixedForm">
        
        <div class="row spacedRow">
        
            <div class="column leftColumn">
            Email:
            </div>
            
            <div class="column middleColumn">
            </div>
            
            <div class="column rightColumn clearfix">
            <input type="text" name="email" id="semail" class="field" />
            </div>
        
        </div>
        
        <div class="row spacedRow">
        
            <div class="column leftColumn">
            Password:
            </div>
            
            <div class="column middleColumn">
            </div>
            
            <div class="column rightColumn clearfix">
            <input type="password" name="password" id="spassword" class="field" />
            </div>
        
        </div>
        
        <div class="row spacedRow">
        
            <div class="column leftColumn">
            Verify Password:
            </div>
            
            <div class="column middleColumn">
            </div>
            
            <div class="column rightColumn clearfix">
            <input type="password" name="vpassword" id="vpassword" class="field" />
            </div>
        
        </div>
        
        <div class="row spacedRow">
        
            <div class="column leftColumn">
            
            </div>
            
            <div class="column middleColumn">
            <input type="submit" value="Create Account" id="signupButton" class="button btn" />
            </div>
            
            <div class="column rightColumn clearfix">
            
            </div>
        
        </div>
        

    
    <div class="row">
    
        <div class="column leftColumn">
       
        </div>
        
        <div class="column middleColumn">
        
        </div>
        
        <div class="column rightColumn clearfix">            
        
        </div>
    
    </div>

        </form>
</cfoutput>
            
          </div><!--/.well -->        
        </div><!--/span-->
        <div class="span5">
          <div class="well">
            
<cfoutput>

    
        <form method="POST" action="/user/login" class="fixedForm">
        
        <div class="row spacedRow">
        
            <div class="column leftColumn">
            Email:
            </div>
            
            <div class="column middleColumn">
            </div>
            
            <div class="column rightColumn clearfix">
            <input type="text" name="email" id="email" class="field" />
            </div>
        
        </div>
        
        <div class="row spacedRow">
        
            <div class="column leftColumn">
            Password:
            </div>
            
            <div class="column middleColumn">
            </div>
            
            <div class="column rightColumn clearfix">
            <input type="password" name="password" id="password" class="field" />
            </div>
        
        </div>       
        
        <div class="row spacedRow">
        
            <div class="column leftColumn">
            
            </div>
            
            <div class="column middleColumn clearfix">
            <input type="button" value="Login" id="loginButton" class="button btn" />
            </div>
            
            <div class="column rightColumn">
            
            </div>
        
        </div>
        

    
    <div class="row">
    
        <div class="column leftColumn">
       
        </div>
        
        <div class="column middleColumn">
        <hr  />
        <a href="http://www.facebook.com/dialog/permissions.request?app_id=0000000000&display=page&redirect_uri=http://www.grapestack.com/facebook&response_type=code&fbconnect=1&perms=email"><img src="/includes/images/facebook.png" border="0" /></a>
        </div>
        
        <div class="column rightColumn clearfix">            
        
        </div>
    
    </div>

        </form>
</cfoutput>
            

        </div><!--/span-->
      </div><!--/row-->      

</div>

      <footer class="footer">
        <p>

        &copy; GRAPE Stack <cfoutput>#dateFormat(now(), "yyyy")#</cfoutput></p>
      </footer>
</div>