$(function(){
	if($("#mp-photos").length > 0){
		function loadPhotos(isinit){
			// 判断窗口的滚动条是否接近页面底部
			var isBottom = $(document).scrollTop() + $(window).height() > $(document).height() - 10,
				eleLoad = $("#page_loading"),
				isLoading = eleLoad.attr('state') == 'load',
				nextPage = eleLoad.attr("page"),
				isNoNextPage = (nextPage == undefined),
				_url = eleLoad.attr('url');
			if(eleLoad.length < 1){
				return;
			}
			if(isinit !== 'init'){
				if(!isBottom || isLoading){
					return false;
				}
			}
			if(isNoNextPage){
				// MPMSG('error', '最后一页了');
				$("#page_loading").remove();
				return;
			}
			// 可以进行一次加载
			$.ajax( {
				url: _url + '&page=' + nextPage,
				type: "get",
				beforeSend: function(){
					// 显示正在加载模块
					eleLoad.show("slow").attr('state', 'load');
				},
				success: function(data){
					nextPage = $(data).attr("page");
					if(nextPage == undefined){
						eleLoad.removeAttr("page");
					} else {
						eleLoad.attr("page", nextPage);
					}
					// 插入数据
					$('#mp-photos').append($(data).html());
				},
				complete: function(){
					// 隐藏正在加载模块
					eleLoad.hide("slow").attr('state', 'staic');
				}
			});
		}
		$(window).bind("scroll", loadPhotos);
		loadPhotos('init');
	}
})