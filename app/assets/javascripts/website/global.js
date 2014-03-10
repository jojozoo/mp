$(function(){
	// /gs/1
	$(document).on('mouseenter', '.ondown', function(){
		$(this).find(".bgdown").css('height', $(this).find(".fadedown").outerHeight());
		$(this).children().slideDown(300);
	}).on('mouseleave', '.ondown', function(){
		$(this).children().slideUp(300);
	});

	// 瀑布流的每张图
	$(document).on("mouseenter", ".thumbnail", function(){
		$(this).find('.fade-row').show();
	}).on('mouseleave', '.thumbnail', function(){
		$(this).find('.fade-row').hide();
	});
})