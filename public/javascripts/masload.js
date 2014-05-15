$(function(){

	var container = $('#container');
	container.imagesLoaded(function(){
        container.masonry({
            itemSelector : '.col-sm-6.col-md-3',
            transitionDuration: '0.8s',
            hiddenStyle: { opacity: 0 },
            visibleStyle: { opacity: 1}
        });
        $('.col-sm-6.col-md-3').animate({'opacity': 1}, 500);
    });

	// start
	// page_loading
	//   page 第几页
	//   state = 'staic/load' 静止/加载
	var loadImage = function(isbottonfalse){
		// 判断窗口的滚动条是否接近页面底部
		var isBottom = $(document).scrollTop() + $(window).height() > $(document).height() - 10;
		// 查看load元素是否存在，如果不存在说明是已经加载完所有并且删除了ele
		var eleLoad = $("#page_loading");
		// 是否正在进行上次加载
		var isPrev = eleLoad.attr('state') == 'load';
		if(!isBottom || eleLoad.length < 1 || isPrev){
			return;
		}
		// 判断是否还有下一页
		var nextPage = eleLoad.attr("page");
		var isNoNextPage = (nextPage == undefined);
		if(isNoNextPage){
			eleLoad.find('span').text("最后一页了");
			eleLoad.show('fast');
			setTimeout('$("#page_loading").remove()', 2000);
			return;
		}
		// 加载地址
		var url = eleLoad.attr('url');

		// 可以进行一次加载
		$.ajax( {
			url: url + '&page=' + nextPage,
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
				result = $(data).find(".col-sm-6.col-md-3").map(function(index, row){
					var img       = $(row).find('img[wh]').attr('wh').split('x');
						imgWidth  = parseInt(img[0] || 250),
						imgHeight = parseInt(img[1] || 160),
						eleWidth  = Math.round((container.width() / 4) - 30);
						eleHeight = Math.round(imgHeight / (Math.round((imgWidth / eleWidth) * 10) / 10));
					$(row).find('img[wh]').css({width: eleWidth, height: eleHeight});
					$(row).find('.details').css({width: eleWidth});
					return row;
				});
				container.append(result);
                container.masonry( 'appended', result );
			},
			complete: function(){
				// 隐藏正在加载模块
				eleLoad.hide("slow").attr('state', 'staic');
			}
		});
	}

	// 加载页面加载一次
	// loadImage(true);

	$(window).bind("scroll", loadImage);

})