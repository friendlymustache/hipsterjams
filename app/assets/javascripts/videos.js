
var voted = false;

$(function(){
	$('#yes_button').mouseup(function(){	
		$(this).attr("class", "btn btn-inverse btn-large");		
		$('#no_button').off("click").attr("class", "btn btn-warning btn-large");
		$(this).on("click", false);
		
		if(voted == true){
			$.get($(this).attr("href")+"&voted=true");				
		}
		else{
			$.get($(this).attr("href"));
			voted = true;				
		}
	
		
	});
	
	

});

$(function(){
	$('#no_button').mouseup(function(){
		$(this).attr("class", "btn btn-inverse btn-large");
		$('#yes_button').off("click").attr("class", "btn btn-success btn-large");
		$(this).on("click" ,false);

		if(voted == true){
			$.get($(this).attr("href")+"&voted=true");				
		}
		else{
			$.get($(this).attr("href"));
			voted = true;				
		}					
	});		
});





$(window).resize(function(){
	var height = $(window).height();
	var wrapper_height = $('#wrapper_and_tabs').outerHeight();
	if(height > wrapper_height){
	var window_o = $(window).scrollTop();
	var wrapper_o = $('#wrapper_and_tabs').offset();
	$('#wrapper_and_tabs').offset({left: wrapper_o.left, top: (height-wrapper_height)/2});
	}
});

$(window).resize();
