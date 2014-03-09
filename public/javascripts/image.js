$(function(){
    $(".ondown").on('mouseenter', function(){
        $(this).find(".bgdown").css('height', $(this).find(".fadedown").outerHeight());
        $(this).children().slideDown(300);
    }).on('mouseleave', function(){
        $(this).children().slideUp(300);
    });
})