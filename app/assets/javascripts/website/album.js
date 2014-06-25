$(function(){
	// 相册
	$(".js-album").hover(function(){
		$(this).find(".hide-cap").show();
	}, function(){
		$(this).find(".hide-cap").hide();
	});
	// 编辑描述
	$(".js-image-desc-edit").on('click', function(){
		$(this).hide();
		$(this).next().show().focus();
	});
	// 编辑描述 完成
	$(".js-image-desc-edit-textarea").on('blur', function(){
		var val  = $(this).val(),
			text = $(this).prev().text();
		$(this).hide();
		$(this).prev().text(val).show();
		if(text != val){
			var _id = $(this).attr('tid');
			$.post('/my/albums/' + _id + '/desc', {desc: val}, function(result){
				MPMSG(result.type, result.text);
			});
			// $.post('/my/albums/' + _id + '/desc', {desc: val}, '', 'script');
		}
	});
	// 批量管理
	$("#album").on('click', function(){
		// :visible
		if($(".album-tool").is(':hidden')){
			$(".album-tool, .hide-cap").show();
			$(".checkbox-layer").css('z-index', 10);
		} else {
			$(".album-tool, .hide-cap").hide();
			$(".checkbox-layer").css('z-index', -10);
		}
	});
	// 全选 / 反选
	$("#album-all-checkbox").on('click', function(){
		var checked = $(this).is(':checked');
		$("input[type=checkbox][id!=album-all-checkbox]").each(function(index, row){
			row.checked = checked;
		});
	});
	// 选择一个
	$(".checkbox-layer").on('click', function(){
		$(this).prev().click();
	});


	// 全选移动
	$("#image-all-move").on('click', function(){
		var checkboxs = $("input[type=checkbox][id!=album-all-checkbox]:checked");
		if(checkboxs.length < 1){
			alert('至少选中1张图片');
			return false;
		} else {
			var url = $(this).attr('href'),
				ids = checkboxs.map(function(){ return this.value; }).get().join(',');
			$.post(url, {ids: ids}, '', 'script');
			return false;
		}
	});

	// 全选删除
	$("#image-all-del").on('click', function(){
		var _this  = this,
			_cboxs = null,
			_state = $(_this).attr("state");
		if(_state === "loading"){
			return false;
		}
		_cboxs = $("input[type=checkbox][id!=album-all-checkbox]:checked");
		if(_cboxs.length < 1){
			MPMSG('error', '至少选中1张图片');
		} else {
			if(confirm("确定删除？不可恢复操作!")){
				_cboxs.each(function(){
					var _del = $(this).parents(".col-sm-6.col-md-3").find('.js-image-remove'),
						_id  = _del.attr("tid"),
						_url = '/ajax/del/photo/' + _id;
					_del.parents(".col-sm-6.col-md-3").fadeOut(function(){
						$(this).remove();
						$.post(_url, '', '');
					});
				});
			}
		}
	});
	// 删除本张
	$(document).on("click", ".js-image-remove", function(){
		var _tid = $(this).attr('tid');
		var url = '/ajax/del/photo/' + _tid;
		$(this).parents(".col-md-3.col-sm-6").fadeOut(function(){
			$(this).remove();
			$.post(url, '', function(result){
				MPMSG(result.type, result.text);
			});
		});
	});
	
	// 封面
	$(".js-album-cover").on('click', function(){
		var _this  = this,
			_url   = $(_this).attr('href'),
			_state = $(_this).attr('state');
		if(_state === "loading"){
			return false;
		}
		$.ajax({
			type: 'post',
			url: _url,
			beforeSend: function(){
				$(_this).attr("state", "loading");
			},
			success: function(result) {
				$(_this).removeAttr("state");
				MPMSG(result.type, result.text);
			}
		});
		return false;
	});
})