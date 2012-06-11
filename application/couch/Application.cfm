<cfapplication name="couchDB" sessionmanagement="yes" setdomaincookies="yes" clientmanagement="yes">
<cfsetting showdebugoutput="no">
<cfset request.couchServer = "http://127.0.0.1:5985/movies">