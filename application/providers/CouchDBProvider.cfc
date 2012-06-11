/**
********************************************************************************
Copyright Since 2005 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
www.coldbox.org | www.luismajano.com | www.ortussolutions.com
********************************************************************************
Author: Luis Majano
Description:
	
This CacheBox provider communicates with the built in caches in
the CouchDB Engine

*/
component serializable="false" implements="coldbox.system.cache.ICacheProvider"{

	/**
    * Constructor
    */
	CouchDBProvider function init() output=false{
		// prepare instance data
		instance = {
			// provider name
			name 				= "CouchDB",
			// provider enable flag
			enabled 			= false,
			// reporting enabled flag
			reportingEnabled 	= false,
			// configuration structure
			configuration 		= {},
			// cacheFactory composition
			cacheFactory 		= "",
			// event manager composition
			eventManager		= "",
			// storage composition, even if it does not exist, depends on cache
			store				= "",
			// the cache identifier for this provider
			cacheID				= createObject('java','java.lang.System').identityHashCode(this),
			// Element Cleaner Helper
			elementCleaner		= CreateObject("component","coldbox.system.cache.util.ElementCleaner").init(this),
			// Utilities
			utility				= createObject("component","coldbox.system.core.util.Util"),
			// our UUID creation helper
			uuidHelper			= createobject("java", "java.util.UUID")
		};
		
		// Provider Property Defaults
		instance.DEFAULTS = {
			cacheName = "object"
		};		
		
		return this;
	}
	
	/**
    * get the cache name
    */    
	any function getName() output=false{
		return instance.name;
	}
	
	/**
    * set the cache name
    */    
	void function setName(required name) output=false{
		instance.name = arguments.name;
	}
	
	/**
    * set the event manager
    */
    void function setEventManager(required any EventManager) output=false{
    	instance.eventManager = arguments.eventManager;
    }
	
    /**
    * get the event manager
    */
    any function getEventManager() output=false{
    	return instance.eventManager;
    }
    
	/**
    * get the cache configuration structure
    */
    any function getConfiguration() output=false{
		return instance.configuration;
	}
	
	/**
    * set the cache configuration structure
    */
    void function setConfiguration(required any configuration) output=false{
		instance.configuration = arguments.configuration;
	}
	
	/**
    * get the associated cache factory
    */
    any function getCacheFactory() output=false{
		return instance.cacheFactory;
	}
	
	/**
	* Validate the incoming configuration and make necessary defaults
	**/
	private void function validateConfiguration(){
		var cacheConfig = getConfiguration();
		var key			= "";
		
		// Validate configuration values, if they don't exist, then default them to DEFAULTS
		for(key in instance.DEFAULTS){
			if( NOT structKeyExists(cacheConfig, key) OR NOT len(cacheConfig[key]) ){
				cacheConfig[key] = instance.DEFAULTS[key];
			}
		}
	}
	
	/**
    * configure the cache for operation
    */
    void function configure() output=false{
		var config 	= getConfiguration();
		var props	= [];
		
		lock name="CouchDBprovider.config.#instance.cacheID#" type="exclusive" throwontimeout="true" timeout="20"{
		
			// Prepare the logger
			instance.logger = getCacheFactory().getLogBox().getLogger( this );
			instance.logger.debug("Starting up CouchDBprovider Cache: #getName()# with configuration: #config.toString()#");
			
			// Validate the configuration
			validateConfiguration();
			
			// enabled cache
			instance.enabled = true;
			instance.reportingEnabled = true;
			instance.logger.info("Cache #getName()# started up successfully");
		}
		
	}
	
	/**
    * shutdown the cache
    */
    void function shutdown() output=false{
		//nothing to shutdown
		instance.logger.info("CouchDBProvider Cache: #getName()# has been shutdown.");
	}
	
	/*
	* Indicates if cache is ready for operation
	*/
	any function isEnabled() output=false{
		return instance.enabled;
	} 

	/*
	* Indicates if cache is ready for reporting
	*/
	any function isReportingEnabled() output=false{
		return instance.reportingEnabled;
	}
	
	/*
	* Get the cache statistics object as coldbox.system.cache.util.ICacheStats
	* @colddoc:generic coldbox.system.cache.util.ICacheStats
	*/
	any function getStats() output=false{
		return createObject("component", "coldbox.system.cache.providers.couchdb-lib.CouchDBStats").init( this );		
	}
	
	/**
    * clear the cache stats: Not enabled in this provider
    */
    void function clearStatistics() output=false{
		// not yet posible with couchdb
	}
	
	/**
    * Returns the underlying cache engine: Not enabled in this provider
    */
    any function getObjectStore() output=false{
		// not yet possible with couchdb
		//return cacheGetSession( getConfiguration().cacheName );
	}
	
	/**
    * get the cache's metadata report
    */
    any function getStoreMetadataReport() output=false{ 
		var md 		= {};
		var keys 	= getKeys();
		var item	= "";
		
		for(item in keys){
			md[item] = getCachedObjectMetadata(item);
		}
		
		return md;
	}
	
	/**
	* Get a key lookup structure where cachebox can build the report on. Ex: [timeout=timeout,lastAccessTimeout=idleTimeout].  It is a way for the visualizer to construct the columns correctly on the reports
	*/
	any function getStoreMetadataKeyMap() output="false"{
		var keyMap = {
				timeout = "timespan", hits = "hitcount", lastAccessTimeout = "idleTime",
				created = "createdtime", lastAccesed = "lasthit"
			};
		return keymap;
	}
	
	/**
    * get all the keys in this provider
    */
    any function getKeys() output=false{
		
		if( isDefaultCache() ){
			return cacheGetAllIds();
		}
		
		return cacheGetAllIds("",getConfiguration().cacheName);
	}
	
	/**
    * get an object's cached metadata
    */
    any function getCachedObjectMetadata(required any objectKey) output=false{
		if( isDefaultCache() ){
			return cacheGetMetadata( arguments.objectKey );
		}
		
		return cacheGetMetadata( arguments.objectKey, getConfiguration().cacheName );
	}
	
	/**
    * get an item from cache
    */
    any function get(required any objectKey) output=false{
	
		if( isDefaultCache() ){
			return cacheGet( arguments.objectKey );
		}
		else{
			return cacheGet( arguments.objectKey, false, getConfiguration().cacheName );
		}
	}
	
	/**
    * get an item silently from cache, no stats advised: Stats not available on couchdb
    */
    any function getQuiet(required any objectKey) output=false{
		// not implemented by couchdb yet
		return get(arguments.objectKey);
	}
	
	/**
    * Not implemented by this cache
    */
    any function isExpired(required any objectKey) output=false{
		return false;
	}
	 
	/**
    * check if object in cache
    */
    any function lookup(required any objectKey) output=false{
		if( isDefaultCache() ){
			return cachekeyexists(arguments.objectKey );
		}
		return cachekeyexists(arguments.objectKey, getConfiguration().cacheName );
	}
	
	/**
    * check if object in cache with no stats: Stats not available on couchdb
    */
    any function lookupQuiet(required any objectKey) output=false{
		// not possible yet on couchdb
		return lookup(arguments.objectKey);
	}
	
	/**
    * set an object in cache
    */
    any function set(required any objectKey,
					 required any object,
					 any timeout="0",
					 any lastAccessTimeout="0",
					 any extra) output=false{
		
		setQuiet(argumentCollection=arguments);
		
		//ColdBox events
		var iData = { 
			cache				= this,
			cacheObject			= arguments.object,
			cacheObjectKey 		= arguments.objectKey,
			cacheObjectTimeout 	= arguments.timeout,
			cacheObjectLastAccessTimeout = arguments.lastAccessTimeout
		};		
		getEventManager().processState("afterCacheElementInsert",iData);
		
		return true;
	}	
	
	/**
    * set an object in cache with no advising to events
    */
    any function setQuiet(required any objectKey,
						  required any object,
						  any timeout="0",
						  any lastAccessTimeout="0",
						  any extra) output=false{
		
		// check if incoming timoeut is a timespan or minute to convert to timespan
		if( findnocase("string", arguments.timeout.getClass().getName() ) ){
			arguments.timeout = createTimeSpan(0,0,arguments.timeout,0);
		}
		if( findnocase("string", arguments.lastAccessTimeout.getClass().getName() ) ){
			arguments.lastAccessTimeout = createTimeSpan(0,0,arguments.lastAccessTimeout,0);
		}
		
        
        http url='http://#instance.configuration.host#:#instance.configuration.port#/#instance.configuration.database#/_design/cache/_view/all?key=%22#arguments.objectKey#%22' method='post' result='local.checkKey' {
        httpparam type='header' value='application/json' name='Content-Type';
        httpparam type='body' value='{}';
        };
        
        local.checkKey = deserializeJSON(local.checkKey.fileContent);
        
		if (arrayLen(local.checkKey.rows) gt 0) {
        	local.cacheMethod = "put";
        } else {
        	local.cacheMethod = "post";
        }

        
		if( isDefaultCache() ){
            
            arguments.object["_id"] = '#arguments.objectKey#';
            arguments.object.timeout = '#arguments.timeout#';
            arguments.object.lastAccess = '#arguments.lastAccessTimeout#';
            if (local.cacheMethod is 'put') {
	            arguments.object["_rev"] = local.checkKey.rows[1].value._rev;
                local.id = arguments.objectKey;
            } else {
            	local.id = '';
            }
            
            http url='http://#instance.configuration.host#:#instance.configuration.port#/#instance.configuration.database#/#local.id#' method='#local.cacheMethod#' result='local.insertCache' {
                httpparam type='body' value='#serializeJSON(arguments.object)#';
                httpparam type='header' value='application/json' name='Content-Type';
            };         
            
		}
		else{

            arguments.object["_id"] = '#arguments.objectKey#';
            arguments.object.timeout = '#arguments.timeout#';
            arguments.object.lastAccess = '#arguments.lastAccessTimeout#';
            if (local.cacheMethod is 'put') {
	            arguments.object["_rev"] = local.checkKey.rows[1].value._rev;
            }
            
            
            http url='http://#instance.configuration.host#:#instance.configuration.port#/#instance.configuration.database#/#local.id#' method='#local.cacheMethod#' result='local.insertCache' {
                httpparam type='body' value='#serializeJSON(arguments.object)#';
                httpparam type='header' value='application/json' name='Content-Type';
            };       

		}
		
		return true;
	}	
		
	/**
    * get cache size
    */
    any function getSize() output=false{
		if( isDefaultCache() ){

            http url='http://#instance.configuration.host#:#instance.configuration.port#/#instance.configuration.database#/_design/cache/_view/total_items?group_level=1' method='post' result='local.getCount' {
			httpparam type='header' value='application/json' name='Content-Type';
			httpparam type='body' value='{}';
            };
          	request.getCount = local.getCount;
            return #arrayLen(deserializeJSON(local.getCount.FileContent).rows)#;

		}

            http url='http://#instance.configuration.host#:#instance.configuration.port#/#instance.configuration.database#/_design/cache/_view/total_items?group_level=1' method='post' result='local.getCount' {
			httpparam type='header' value='application/json' name='Content-Type';
			httpparam type='body' value='{}';
            };
            
            return #arrayLen(deserializeJSON(local.getCount.FileContent).rows)#;

	}
	
	/**
    * Not implemented by this cache
    */
    void function reap() output=false{
		// Not implemented by this provider
	}
	
	/**
    * clear all elements from cache
    */
    void function clearAll() output=false{
		var iData = {
			cache	= this
		};
		
		if( isDefaultCache() ){
			cacheClear();
		}
		else{
			cacheClear("",getConfiguration().cacheName);
		}
		
		// notify listeners		
		getEventManager().processState("afterCacheClearAll",iData);
	}
	
	/**
    * clear an element from cache
    */
    any function clear(required any objectKey) output=false{
		
        http url='http://#instance.configuration.host#:#instance.configuration.port#/#instance.configuration.database#/_design/cache/_view/all?key=%22#arguments.objectKey#%22' method='post' result='local.checkKey' {
        httpparam type='header' value='application/json' name='Content-Type';
        httpparam type='body' value='{}';
        };
        
        local.checkKey = deserializeJSON(local.checkKey.fileContent);
        
        if (isDefined("local.checkKey.rows[1]")) {
        
            local.cacheMethod = "delete";
            
            if( isDefaultCache() ){
    
                arguments.object["_id"] = '#arguments.objectKey#';
                arguments.object["_rev"] = local.checkKey.rows[1].value._rev;
                local.id = arguments.objectKey;
                
                http url='http://#instance.configuration.host#:#instance.configuration.port#/#instance.configuration.database#/#local.id#?rev=#arguments.object["_rev"]#' method='#local.cacheMethod#' result='local.insertCache' {
                    httpparam type='header' value='application/json' name='Content-Type';
                }; 
                
            }
            else{
    
                arguments.object["_id"] = '#arguments.objectKey#';
                arguments.object["_rev"] = local.checkKey.rows[1].value._rev;
                local.id = arguments.objectKey;
                
                http url='http://#instance.configuration.host#:#instance.configuration.port#/#instance.configuration.database#/#local.id#?rev=#arguments.object["_rev"]#' method='#local.cacheMethod#' result='local.insertCache' {
                    httpparam type='header' value='application/json' name='Content-Type';
                }; 
    
            }
            
		}
		
		//ColdBox events
		var iData = { 
			cache				= this,
			cacheObjectKey 		= arguments.objectKey
		};		
		getEventManager().processState("afterCacheElementRemoved",iData);
		
		return true;
	}
	
	/**
    * clear with no advising to events
    */
    any function clearQuiet(required any objectKey) output=false{
		// normal clear, not implemented by couchdb
		clear(arguments.objectKey);
		return true;
	}
	
	/**
	* Clear by key snippet
	*/
	void function clearByKeySnippet(required keySnippet, regex=false, async=false) output=false{
		var threadName = "clearByKeySnippet_#replace(instance.uuidHelper.randomUUID(),"-","","all")#";
		
		// Async? IF so, do checks
		if( arguments.async AND NOT instance.utility.inThread() ){
			thread name="#threadName#"{
				instance.elementCleaner.clearByKeySnippet(arguments.keySnippet,arguments.regex);
			}
		}
		else{
			instance.elementCleaner.clearByKeySnippet(arguments.keySnippet,arguments.regex);
		}
	}
	
	/**
    * not implemented by cache
    */
    void function expireAll() output=false{ 
		// Not implemented by this cache
	}
	
	/**
    * not implemented by cache
    */
    void function expireObject(required any objectKey) output=false{
		//not implemented
	}
	
	/**
	* Checks if the default cache is in use
	*/
	private any function isDefaultCache(){
		return  ( getConfiguration().cacheName EQ instance.DEFAULTS.cacheName );
	}
	
	/**
    * set the associated cache factory
    */
    void function setCacheFactory(required any cacheFactory) output=false{
		instance.cacheFactory = arguments.cacheFactory;
	}

}