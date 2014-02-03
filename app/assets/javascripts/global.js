$(function(){
    // 下拉按钮， hover显示
    $('li.dropdown').hover(function(){
        $(this).find('.dropdown-menu').show();
    }, function(){
        $(this).find('.dropdown-menu').hide();
    })


})