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
    // TODO bug 连续刷新两次就会重叠，应该改ajax请求，不响应不进行下一次请求。
    // TODO bug loading图最后一次加载,loading会页面保留. 应该不显示loading图或者重写样式也行
    container.infinitescroll({
        loading: {
            finished: undefined,
            finishedMsg: "<em>what.</em>",
            img: "",
            msg: null,
            msgText: "<em>loading</em>",
            selector: null,
            speed: 'fast',
            start: undefined
            },
        navSelector  : ".pagination",
        nextSelector : ".pagination a",
        itemSelector : ".col-sm-6.col-md-3" ,
        pixelsFromNavToBottom: 300
    },
    function( newElements ) {
        var newElems = $( newElements );
        newElems.imagesLoaded(function(){
            container.masonry( 'appended', newElems);
            // newElems.each(function(){$(this).animate({'opacity': 1}, 500);})
        });
    });


    $(".thumbnail").on('mouseenter', function(){
        $(this).find('.fade-row').show();
    }).on('mouseleave', function(){
        $(this).find('.fade-row').hide();
    });
});