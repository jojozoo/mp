$(function(){
    // 下拉按钮， hover显示
    $('.navbar li.dropdown').hover(function(){
        $(this).find('.dropdown-menu').show();
    }, function(){
        $(this).find('.dropdown-menu').hide();
    });

    // 全局 modal
    $(".custom-modal").on('click', function(){
        $('#custom-modal').modal('show').on('shown.bs.modal', function(){
            $(this).find('input:visible:first').focus().end().find('form').enableClientSideValidations();
        });
    });

    // 生日
	$('.datepicker-start').datetimepicker({
		linkFormat: 'yyyy-mm-dd',
		format: 'yyyy-mm-dd',
		language:  'zh-CN',
		weekStart: 1,
		todayBtn:  1,
		autoclose: 1,
		todayHighlight: 1,
		startView: 2,
		minView: 2,
		forceParse: 0
	})

})

function MPMSG(glass, msg){
    var glass = 'msg-' + glass;
    $("#msgbox").attr('class', glass).find("p").text(msg).end().animate({'opacity': 1, 'top': 0}, 500);
    setTimeout(function(){
        $("#msgbox").animate({'opacity': 0, 'top': -37}, 500);
    }, 3000);
}