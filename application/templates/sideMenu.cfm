<cfswitch expression="#Event.getCurrentHandler()#">

    <cfcase value="admin">
    
		<cfoutput>
        
            <ul class="">
            
                <li class="#defaults['admin.users']#" data-link="/admin/users">
                    <a href="/admin/users">Users</a>
                </li>
            
                </li>
            
            </ul>               
        
                <cfswitch expression="#Event.getCurrentAction()#">
                                                     
                    <cfcase value="users">
                    
                        <ul class="">
                        
                            <li class=" #defaults['admin.users.manage']#" data-link="/admin/users/manage">
                                <a href="/admin/users/manage">Manage</a>
                            </li>
                        
                            <li class="#defaults['sample.link']#" data-link="/sample/link">
                                <a href="/sample/link">Sample Link</a>
                            </li>
                        
                        </ul>
                        
                    </cfcase>               
                
                </cfswitch>
        
        </cfoutput>
    
    </cfcase>
            
</cfswitch>