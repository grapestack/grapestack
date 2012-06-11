component 
displayname="role" 
hint="I am a model of a role" 
output="false" 
persistent="true" 
table="roles"
{ 
    property name="roleid" generator="native" index="true" fieldtype="id" ormtype="double";
    property name="rolename" ormtype="string";
}
