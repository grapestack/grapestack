<cfoutput>

<cfif isDefined("rc.subItem")>

	<cfswitch expression="#rc.subItem#">
    
		<cfcase value="new">
		   
			<cfinclude template="/templates/users/manage/new.cfm">
			
		</cfcase>
        
		<cfcase value="edit">
		   
			<cfinclude template="/templates/users/manage/edit.cfm">
			
		</cfcase>
        
	</cfswitch>

<cfelse>

    <div class="hRow">
    <a class="btn primary" data-controls-modal="newUserForm" data-backdrop="static" data-keyboard="true">new user</a>
    </div>
    
    <hr>
    
    <div id="userList">

                <cfloop array="#rc.users#" index="user">
                
                <div class="hRow">
                <a href="/admin/users/manage/edit/#user.userID#">#user.email#</a>
                </div>
                
                </cfloop>
              
	</div>
    
    <div id="newUserForm" class="modal hide">
    
			<div class="modal-header">
              <a href="##" class="close">&times;</a>
              <h3>New User</h3>
            </div>
            <div class="modal-body">
              <p>
              
                <form method="POST" action="/admin/users/manage/create">
                
                <div class="hRow">
                
                    <div class="column leftColumn">
                    Email:
                    </div>
                    
                    <div class="column middleColumn">
                    </div>
                    
                    <div class="column rightColumn">
                    <input type="text" name="email" id="email" class="field" />
                    </div>
                
                </div>
                
                <div class="hRow">
                
                    <div class="column leftColumn">
                    Password:
                    </div>
                    
                    <div class="column middleColumn">
                    </div>
                    
                    <div class="column rightColumn">
                    <input type="password" name="password" id="password" class="field" />
                    </div>
                
                </div>
                
                <cfset rc.roles = EntityLoad('role')>
                
                <cfoutput>
                <cfloop array="#rc.roles#" index="role">
                
                <div class="hRow">
                
                    <div class="column leftColumn">
                    #role.roleName#
                    </div>
                    
                    <div class="column middleColumn">
                    </div>
                    
                    <div class="column rightColumn">
                    <input type="checkbox" name="roles" class="field" value="#role.roleID#" />
                    </div>
                
                </div>
                
                </cfloop>
                </cfoutput>
                
                <div class="hRow">
                
                    <div class="column leftColumn">
                    
                    </div>
                    
                    <div class="column middleColumn">
                    
                    </div>
                    
                    <div class="column rightColumn">
                    
                    </div>
                
                </div>
                
                
              
              </p>
            </div>
            <div class="modal-footer">
              <input type="submit" value="Create" id="createButton" class="button btn primary" />
              <a href="##" class="btn secondary" onclick="$('##newUserForm').modal('hide');">Cancel</a>
            </div>
				</form>
	</div>

</cfif>

</cfoutput>