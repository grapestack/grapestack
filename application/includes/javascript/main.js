jQuery(document).ready(function(){
		
	$("#loginButton").bind("click", function(e) {
		
		var postData = {};
	
		postData.returnFormat = 'JSON';
		postData.email = $("#email").val();
		postData.password = $("#password").val();
		
		$.ajax({
			url: '/rest/login',
			method: 'POST',
			data: postData,
			dataType: 'json',
			success: function(data){
				if (data == true) {
					window.location = '/';
					return true;
				} else {
					return false;
				}
			},
			error: function(data){
				return false;
			}
		});
		
	});
	
	$(".menu, .nav, .well").delegate(".menuItem", "click", function() {
		window.location = $(this).attr("data-link");
	});
	
	$(".btn-group").delegate(".btn", "click", function() {
//		$("#"+$(this).attr("data-radio-field")).val($(this).attr("data-radio-value"));			
		$(this).parent().next().val($(this).attr("data-radio-value"));
	});
	
});