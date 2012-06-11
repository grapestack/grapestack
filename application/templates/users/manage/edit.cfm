<cfoutput>

<form method="POST" action="/admin/users/manage/update/#rc.itemID#">

<div class="row">

    <div class="column leftColumn">
    Email:
    </div>
    
    <div class="column middleColumn">
    </div>
    
    <div class="column rightColumn">
    <input type="text" name="email" id="email" class="field" value="#rc.user.email#" />
    </div>

</div>

<div class="row">

    <div class="column leftColumn">
    Password:
    </div>
    
    <div class="column middleColumn">
    </div>
    
    <div class="column rightColumn">
    <input type="password" name="password" id="password" class="field" value="#rc.user.password#" />
    </div>

</div>

<cfset rc.roles = EntityLoad('role')>

<cfoutput>
<cfloop array="#rc.roles#" index="role">

<cfset rc.role = EntityLoad('role', role.roleID)[1]>

<div class="row">

    <div class="column leftColumn">
    #role.roleName#
    </div>
    
    <div class="column middleColumn">
    </div>
    
    <div class="column rightColumn">
    <input type="checkbox" name="roles" class="field" value="#role.roleID#" <cfif rc.user.hasRoles(rc.role)>checked="true"</cfif> />
    </div>

</div>

</cfloop>
</cfoutput>

<div class="row">

    <div class="column leftColumn">
    
    </div>
    
    <div class="column middleColumn">
    <input type="submit" value="Save" id="saveButton" class="button" />
    </div>
    
    <div class="column rightColumn">
    
    </div>

</div>

</form>

</cfoutput>