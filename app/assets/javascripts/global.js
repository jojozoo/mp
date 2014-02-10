$(function(){
    // 下拉按钮， hover显示
    $('li.dropdown').hover(function(){
        $(this).find('.dropdown-menu').show();
    }, function(){
        $(this).find('.dropdown-menu').hide();
    });

    // 全局 modal
    $(".custom-modal").on('click', function(){
        $('#custom-modal').modal('show');
    });

    // 生日
	$('#datepicker').datetimepicker({
		linkFormat: 'yyyy-mm-dd',
		format: 'yyyy-mm-dd',
		language:  'zh-CN',
		weekStart: 1,
		todayBtn:  1,
		autoclose: 1,
		todayHighlight: 1,
		startView: 2,
		minView: 2,
		forceParse: 0,
		onClose: function(dateText, inst) { $(inst.input).change().focusout();}
	})
	// .on('changeDate', function(ev){
	// 	$(ev.target).find('input').change().focusout();
	// });

})