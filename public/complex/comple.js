$(function(){
	$('#clickupload').uploadify();

	// 单击上传
	$(document).on("click", "a.submit", function(){
		var _queue = $(".uploadcom .col-md-12[data-tpid]"),
			_event = $("#event_div input").val(),
			_title = $("#title_div input").val(),
			_desc = $("#desc_div textarea").val();


		if(_queue.length < 1){
			MPMSG("error", "还没有上传作品");
			return false;
		}
		if(_event == ""){
			MPMSG("error", "活动必选");
			return false;
		}
		if(_title == ""){
			MPMSG("error", "标题不能为空");
			return false;
		}
		if(_desc == ""){
			MPMSG("error", "内容不能为空");
			return false;
		}
	});

	// 向上移动
	$(document).on("click", ".gototop", function(){

	});
	// 向下移动
	$(document).on("click", ".gotobottom", function(){
		
	});
	// 封面
	$(document).on("click", ".gotocover", function(){
		$(".setcover").hide();
		$(this).parents(".col-md-12").find(".setcover").show();
		var gl = $(this).parents(".col-md-12").data("tpid");
		$("#photo_gl_id").val(gl);
	});
	// 删除
	$(document).on("click", ".gotodel", function(){
		var _glid = $(this).parents(".col-md-12").data("tpid");
		$(this).parents(".col-md-12").fadeOut(300, function(){
			$(this).remove();
			if($("#photo_gl_id").val()  == _glid){
				$(".uploadcom .gotocover:last").click();
			}
			
		});
	});
});