<cfscript>

            http url='http://couchdb.grapestack.com:5984/cache/_design/cache/_view/total_items?group_level=1' method='post' result='local.getCount' {
			httpparam type='header' value='application/json' name='Content-Type';
			httpparam type='body' value='{}';
            };
            
            writeDump(#local.getCount.fileContent#);
			
            http url='http://couchdb.grapestack.com:5984/cache/' method='post' result='local.insertCache' {
                httpparam type='body' value='{"_id": "myTest","item": "test","timeout": "60","lastAccess": "60","type": "cache"}';
                httpparam type='header' value='application/json' name='Content-Type';
            };
			
            writeDump(#local.getCount.fileContent#);

</cfscript>