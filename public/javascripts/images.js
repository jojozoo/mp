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
    // 给浏览器窗口绑定 scroll 事件
    $(window).bind("scroll",function(){
        // 判断窗口的滚动条是否接近页面底部
        if( $(document).scrollTop() + $(window).height() > $(document).height() - 10 ) {
            // 判断下一页链接是否为空
            var nextPage = $("#container").attr("np");
            if( nextPage != undefined ) {
                // Ajax 翻页
                $.ajax( {
                    url: '/gs?page=' + nextPage,
                    type: "get",
                    async: false,
                    beforeSend: function(){
                        // 显示正在加载模块
                        $("#page_loading").show("slow");
                    },
                    success: function(data) {
                        result = $(data).find(".col-sm-6.col-md-3");
                        nextPage = $(data).attr("np");
                        if(nextPage == undefined){
                            $("#container").removeAttr("np");
                        } else {
                            $("#container").attr("np", nextPage);
                        }
                        $("#container").append(result);
                        // 把新的内容设置为透明
                        newElems = result.css({ opacity: 0 });
                        newElems.imagesLoaded(function(){
                            container.masonry( 'appended', newElems, true );
                            // 渐显新的内容
                            newElems.animate({ opacity: 1 });
                        });
                    },
                    complete: function(){
                        // 隐藏正在加载模块
                        $("#page_loading").hide("slow");
                    }
                });
            } else {
                $("#page_loading span").text("木有了噢，最后一页了！");
                $("#page_loading").show("fast");
                setTimeout("$('#page_loading').hide()",1000);
                setTimeout("$('#page_loading').remove()",1100);
            }
        }
    });


    $(".thumbnail").on('mouseenter', function(){
        $(this).find('.fade-row').show();
    }).on('mouseleave', function(){
        $(this).find('.fade-row').hide();
    });
});