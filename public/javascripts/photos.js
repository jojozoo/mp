// $(function(){

// 	var MPJS;
// 	if (MPJS == undefined) {
// 		MPJS = function (settings) {
// 			this.initMPJS(settings);
// 		};
// 	}
// 	// 初始化
// 	MPJS.prototype.initMPJS = function(settings){

// 	}

// 	// 自动加载图片 par 是否是初始化加载
// 	MPJS.autoLoad = function(){
// 		this.page = 1;
// 		this.loading = 0;
// 		this.nextPage = 1;
// 		this.loadItem = "mp-photos";

		
// 	};
// 	var autoload = new MPJS.autoload();

// 	MPJS.autoLoad.prototype.init = function(isinit){
// 		if(isinit){

// 		}
// 	}

// });

$(function(){
	// start
	// page_loading
	// page 第几页
	// state = 'staic/load' 静止/加载
	var loadImage = function(isinit){
		// 判断窗口的滚动条是否接近页面底部
		var isBottom = $(document).scrollTop() + $(window).height() > $(document).height() - 10;
		// 查看load元素是否存在，如果不存在说明是已经加载完所有并且删除了ele
		var eleLoad = $("#page_loading");
		// 是否正在进行上次加载
		var isLoading = eleLoad.attr('state') == 'load';
		if(!isinit || !isBottom || isLoading){
			return;
		}
		// 判断是否还有下一页
		var nextPage = eleLoad.attr("page");
		var isNoNextPage = (nextPage == undefined);
		if(isNoNextPage){
			eleLoad.find('span').text("最后一页了");
			eleLoad.show('fast');
			setTimeout('$("#page_loading").remove()', 1000);
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
				$('#mp-photos').append($(data).html());
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
	loadImage(true);

})