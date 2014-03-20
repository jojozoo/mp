$(function(){
    // 下拉按钮， hover显示
    $('li.dropdown').hover(function(){
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
	// .on('changeDate', function(ev){
	// 	$(ev.target).find('input').change().focusout();
	// });

})