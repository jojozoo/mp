window.console&&window.console.info("俩月的苦战,急需一位小伙伴。\nemail hr@mpwang.com.cn");
function MPMSG(glass, msg){
    var glass = 'msg-' + glass;
    $("#msgbox").attr('class', glass).find("p").text(msg).end().animate({'opacity': 1, 'top': 0}, 500);
    setTimeout(function(){
        $("#msgbox").animate({'opacity': 0, 'top': -37}, 500);
    }, 3000);
}
$(function(){
	// bgdown ondown fade-row fadedown choose-ok
	// 以上class 都是 移动显示，移出隐藏 需要整合
	// /p/1
	// $(document).on('mouseenter', '.ondown', function(){
	// 	$(this).find(".bgdown").css('height', $(this).find(".fadedown").outerHeight());
	// 	$(this).children().slideDown(300);
	// }).on('mouseleave', '.ondown', function(){
	// 	$(this).children().slideUp(300);
	// });

	// 瀑布流的每张图
	// $(document).on("mouseenter", ".thumbnail", function(){
	// 	$(this).find('.fade-row').show();
	// }).on('mouseleave', '.thumbnail', function(){
	// 	$(this).find('.fade-row').hide();
	// });

	// 回应 评论
	$(document).on("click", ".reply-link", function(){
		var _id   = $(this).data("id"),
		_name = $(this).data("name")
		$("#comment_reply_id").val(_id);
		$("#replywho").find("small").text(_name).end().show();
	});
	$(document).on("click", "#link-remove", function(){
		$("#comment_reply_id").removeAttr('value');
		$("#replywho").hide();
	});

	// 关注
	$(document).on("click", ".mp-ajax-fol", function(){
		var _this = this,
			_state = $(this).attr("state"),
			_url = $(this).attr("href");
		if(_state === "loading"){
			return false;
		}
		$.ajax({
			type: "post",
			url: _url,
			beforeSend: function(){
				$(_this).attr("state", "loading");
			},
			success: function(result) {
				$(_this).removeAttr("state");
				MPMSG(result.type, result.text);
				if(result.type === 'error'){
					return false;
				}
				if($(_this).hasClass('btn-fold')){
					$(_this).removeClass('btn-fold').text("关注");
				} else {
					$(_this).addClass('btn-fold').text("取消关注");
				}
			}
		});
		return false;
	})
	// 编辑推荐, 今日精选
	$(document).on("click", ".mp-ajax-tui", function(){
		var _type = $(this).data('type');
		res = {
			rec: ['编辑推荐', '取消推荐'],
			cho: ['今日精选', '取消精选'],
			lik: ['喜欢', '喜欢'],
			sto: ['收藏', '收藏']
		}[_type];
		var _this = this,
			_url = $(_this).attr("href"),
			_state = $(_this).attr("state");
		
		if(_state === "loading"){
			return false;
		}
		$.ajax({
			type: "post",
			url: _url,
			// data: {},
			beforeSend: function(){
				$(_this).attr("state", "loading");
			},
			success: function(result) {
				$(_this).removeAttr("state");
				MPMSG(result.type, result.text);
				if(result.type === 'error'){
					return false;
				}
				if(_type === "lik" || _type === "sto"){
					var _count = parseInt($(_this).find(".count").text());
					if($(_this).hasClass('active')){
						$(_this).removeClass('active').find(".count").text(_count - 1);
					} else {
						$(_this).addClass('active').find(".count").text(_count + 1);
					}
				} else {
					if($(_this).hasClass('active')){
						$(_this).removeClass('active').text(res[0]);
					} else {
						$(_this).addClass('active').text(res[1]);
					}
				}
			}
		});
		return false;
	});
	
	// 喜欢
	// 收藏
	// 查看原图
	// 删除


	// 选为封面
	// $(document).on("click", ".js-image-cover", function(){
	// 	var _tid = $(this).attr('tid');
	// 	if($(this).hasClass('js-image-cover-page')){
	// 		$(this).removeClass('js-image-cover-page');
	// 		$('#work_cover_id').removeAttr('value');
	// 		$('#cover-id').removeAttr('value');
	// 	} else {
	// 		$(".js-image-cover.js-image-cover-page").removeClass('js-image-cover-page');
	// 		$(this).addClass('js-image-cover-page');
	// 		$('#work_cover_id').val(_tid);
	// 		$('#cover-id').removeAttr('value');
	// 	}
	// });

	// 删除本张
	// $(document).on("click", ".js-image-remove", function(){
	// 	var _tid = $(this).attr('tid');
	// 	var url = '/ajax/del/image/' + _tid;
	// 	$(this).parents(".col-md-3.col-sm-6").fadeOut(function(){
	// 		$(this).remove();
	// 		$.post(url, '', '', 'script');
	// 	});
	// });
})