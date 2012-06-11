<div id="color_container"></div>
<div id="sidebar"></div>

<script type="text/template" id="color_template">
	<label>Change Color</label>
	<input type="text" id="color_input" />
	<input type="button" id="color_button" value="Change" />
</script>

<script type="text/javascript">
	
$(function() {
	
	var Sidebar = Backbone.Model.extend({
	  promptColor: function() {
		var cssColor = prompt("Please enter a CSS color:");
		this.set({color: cssColor});
	  }
	});
	
	window.sidebar = new Sidebar;
	
	sidebar.on('change:color', function(model, color) {
	  $('#sidebar').css({background: color});
	});
	
	sidebar.set({color: 'white'});	
	
	var ItemView = Backbone.View.extend({
	
		el: '#sidebar',
		
		model: sidebar,
		
		initialize : function(options) {
			this.render = _.bind(this.render, this); 
			this.model.bind('change:color', this.render);
		},
		
		events: {
			"click input[type=button]": "docolor"
		},
		
		render: function(){
			var template = _.template( $("#color_template").html(), {} );
			$(this.el).html( template );
		},
		
		docolor: function( event ){
			sidebar.set({color: $("#color_input").val()});
		}
		
	});

var item = new ItemView().render();
	
});

</script>

<style type="text/css">

#sidebar {
	height: 50px;
	width: 500px;
}

</style>