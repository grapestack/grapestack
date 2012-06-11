<cfscript>

labels = {};

menu = {
		'admin':
		{
			'users':'manage'
		},
		
		'sample':
		{
			'link':''
		}
	};

	labels['sample.link'] = 'Sample';

	for ( var key in menu ) {
		
		menuIterator = 0;		
		
		var item = menu[key];
		
		param name="defaults['#key#']" default="";
		param name="labels['#key#']" default=key;
		
			if (isStruct(menu[key])) {
				
				menuIterator++;			
		
				for ( var key2 in menu[key] ) {
					
					var item = menu[key][key2];
					
					param name="defaults['#key#.#key2#']" default="";
					param name="labels['#key#.#key2#']" default='#key#.#key2#';
					
						if (isStruct(menu[key][key2])) {
							
							menuIterator++;	
							
							for ( var key3 in menu[key][key2] ) {
								
								var item = menu[key][key2][key3];

								param name="defaults['#key#.#key2#.#key3#']" default="";
								param name="labels['#key#.#key2#.#key3#']" default='#key#.#key2#.#key3#';
								
								if (isStruct(menu[key][key2][key3])) {

									menuIterator++;										
									
								} else {
									
									for ( var i = 1; i<=listLen(menu[key][key2][key3]); i++ ) {							
										
										param name="defaults['#key#.#key2#.#key3#.#listGetAt(menu[key][key2][key3],i)#']" default="";
										param name="labels['#key#.#key2#.#key3#.#listGetAt(menu[key][key2][key3],i)#']" default='#key#.#key2#.#key3#.#listGetAt(menu[key][key2][key3],i)#';
										
									}
										
								}
								
							}
														
						} else {
														
							menuIterator++;	
							
							for ( var i = 1; i<=listLen(menu[key][key2]); i++ ) {							
								
								param name="defaults['#key#.#key2#.#listGetAt(menu[key][key2],i)#']" default="";
								param name="labels['#key#.#key2#.#listGetAt(menu[key][key2],i)#']" default='#key#.#key2#.#listGetAt(menu[key][key2],i)#';
								
							}
							
						}
					
				}
	
		}
		
	}

	for ( var key in menu ) {
		
		menuIterator = 0;		
		
		var item = menu[key];
		
			if (Event.getCurrentHandler() is key) {
				defaults['#key#'] = 'active';
				labels['#key#'] = key;
			}
		
			if (isStruct(menu[key])) {
				
				menuIterator++;			
		
				for ( var key2 in menu[key] ) {
					
					var item = menu[key][key2];
					
						if (Event.getCurrentHandler() is key and Event.getCurrentAction() is key2) {
							defaults['#key#.#key2#'] = 'active';
						}
					
						if (isStruct(menu[key][key2])) {
							
							menuIterator++;	
							
							for ( var key3 in menu[key][key2] ) {
								
								var item = menu[key][key2][key3];
								
									if (Event.getCurrentHandler() is key and Event.getCurrentAction() is key2 and isDefined("rc.item") and rc.item is key3) {
										defaults['#key#.#key2#.#key3#'] = 'active';
									}
								
								if (isStruct(menu[key][key2][key3])) {
									
									menuIterator++;			
									
								} else {
									
									for ( var i = 1; i<=listLen(menu[key][key2][key3]); i++ ) {							
										if (Event.getCurrentHandler() is key and Event.getCurrentAction() is key2 and isDefined("rc.item") and rc.item is key3 and isDefined("rc.subItem") and rc.subItem is '#listGetAt(menu[key][key2][key3],i)#') {
											defaults['#key#.#key2#.#key3#.#listGetAt(menu[key][key2][key3],i)#'] = 'active';
										}
									}
										
								}
								
							}
														
						} else {
														
							menuIterator++;	
							
							for ( var i = 1; i<=listLen(menu[key][key2]); i++ ) {
								
									if (Event.getCurrentHandler() is key and Event.getCurrentAction() is key2 and isDefined("rc.item") and rc.item is listGetAt(menu[key][key2],i)) {
										defaults['#key#.#key2#.#listGetAt(menu[key][key2],i)#'] = 'active';
									}
								
							}
							
						}
					
				}
	
		}
		
	}

</cfscript>