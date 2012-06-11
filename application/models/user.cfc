component 
displayname="user" 
hint="I am a model of a user" 
output="false" 
persistent="true" 
table="users"
{ 
    property name="userid" generator="native" index="true" fieldtype="id" ormtype="int";
    property name="username" ormtype="string";
    property name="userUUID" ormtype="string";
    property name="email" ormtype="string";
    property name="displayName" ormtype="string";
    property name="password" ormtype="string";
    property name="facebookID" ormtype="long";
    property name="facebookToken" ormtype="string";
	property name="roles" fieldtype="many-to-many" fkcolumn="userID" cfc="role" linktable="userroles" inversejoincolumn="roleID" lazy="true" cascade="all";
    
}
