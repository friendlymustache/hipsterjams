
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



$(function(){
$.ajaxSetup({
  headers: {
    'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
  }
});

$(window).resize(function(){
	var height = $(window).height();
	var wrapper_height = $('#wrapper').outerHeight();
	var window_o = $(window).scrollTop();
	var wrapper_o = $('#wrapper').offset();
	$('#wrapper').offset({left: wrapper_o.left, top: (height-wrapper_height)/2});
});

$(window).resize();
	
});
