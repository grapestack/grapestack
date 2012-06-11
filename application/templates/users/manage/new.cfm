<form method="POST" action="/admin/users/manage/create">

<div class="row">

    <div class="column leftColumn">
    Email:
    </div>
    
    <div class="column middleColumn">
    </div>
    
    <div class="column rightColumn">
    <input type="text" name="email" id="email" class="field" />
    </div>

</div>

<div class="row">

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

<div class="row">

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

<div class="row">

    <div class="column leftColumn">
    
    </div>
    
    <div class="column middleColumn">
    <input type="submit" value="Create" id="createButton" class="button btn primary" />
    </div>
    
    <div class="column rightColumn">
    
    </div>

</div>

</form>