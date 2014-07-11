$(function(){
	$("body").css("height", $(window).height());
	$(document).on(".app_del", "click", function(){
		$(".app_tip").addClass("hide");
	})
});