window.console&&window.console.info("喜欢看漫拍的代码，还是发现了什么bug？不如和我们一起为漫拍添砖加瓦吧！\nmail 1@mpwang.com.cn");
$(function(){
	// bgdown ondown fade-row fadedown choose-ok
	// 以上class 都是 移动显示，移出隐藏 需要整合
	// /p/1
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

	// 回应 评论
	$(".reply-link").on("click", function(){
		var _id   = $(this).data("id"),
		_name = $(this).data("name")
		$("#comment_reply_id").val(_id);
		$("#replywho").find("small").text(_name).end().show();
	});
	$("#link-remove").click(function(){
		$("#comment_reply_id").removeAttr('value');
		$("#replywho").hide();
	});

	// 选为封面
	$(document).on("click", ".js-image-cover", function(){
		var _tid = $(this).attr('tid');
		if($(this).hasClass('js-image-cover-page')){
			$(this).removeClass('js-image-cover-page');
			$('#work_cover_id').removeAttr('value');
			$('#cover-id').removeAttr('value');
		} else {
			$(".js-image-cover.js-image-cover-page").removeClass('js-image-cover-page');
			$(this).addClass('js-image-cover-page');
			$('#work_cover_id').val(_tid);
			$('#cover-id').removeAttr('value');
		}
	});

	// 删除本张
	$(document).on("click", ".js-image-remove", function(){
		var _tid = $(this).attr('tid');
		var url = '/ajax/del/image/' + _tid;
		$(this).parents(".col-md-3.col-sm-6").fadeOut(function(){
			$(this).remove();
			$.post(url, '', '', 'script');
		});
	});
})