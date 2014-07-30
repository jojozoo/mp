$(function(){
	// 选择标签
	$(document).on("keydown", ".tag_field input", function(e){
		var val = $.trim($(this).val());
		if(val == ""){
			return;
		}
		e = e || window.event;
		var lastChar = val.slice(-1);
		if(lastChar == ','){
			val = val.replace(",", "");
			e.keyCode = 9;
		}
		if(e.keyCode == 9 || e.keyCode == 13){
			if(val.length > 10){
				alert("最长10个字符");
				e.returnValue = false;
				e.cancel = true;
				return false;
			}
			var str = '<div class="tag"><div class="name">'+ val +'</div><div class="remove">×</div></div>';
			var _width = $(this).width(),
			_jk    = $(this).parent().before(str).prev().width(),
			_rw    = (_width - _jk) < 170 ? 170 : (_width - _jk);
			$(this).val('').css({width: _rw});
			$("#photo-tags").val($(".tag .name").map(function(){return $(this).text()}).get().join(","));
			e.returnValue = false;
			e.cancel = true;
			return false;
		}
	});
	// 选择标签 end

	 // 常用标签添加
	$(document).on("click", ".tag-changyong a", function(){
		if($(this).hasClass("disabled")){
			return false;
		};
		var val = $(this).text(); 
		$(this).parents('.tag-textfield').find('input').val(val + ",").keydown();
		return false;
	});
	// 常用标签添加 end
	// 删除标签
	$(document).on("click", ".map .remove", function(){
		$(this).parents(".tag").remove();
		$("#photo-tags").val($(".tag .name").map(function(){return $(this).text()}).get().join(","));
	});
	// 删除标签 end

	function initCrop(id){
		// TODO Bug 要等图片加载完了
		var attr = Mpupload.queue[id].crop;
		var p = {aspectRatio: 1, onChange: cutPhoto, onSelect: cutPhoto};
		if(attr.cw == 0 && attr.ch == 0 && attr.cx == 0 && attr.cy == 0){
		} else {
			p['setSelect'] = [attr.cx, attr.cy, attr.cw, attr.ch];
		}
		$(".photo-preview[data-pid=" + id + "] img").Jcrop(p);

		function cutPhoto(cood){
			var w = cood.w * attr.oscale,
			h = cood.h * attr.oscale,
			x = cood.x * attr.oscale,
			y = cood.y * attr.oscale;
			Mpupload.queue[id].crop.cw = cood.w;
			Mpupload.queue[id].crop.ch = cood.h;
			Mpupload.queue[id].crop.cx = cood.x;
			Mpupload.queue[id].crop.cy = cood.y;
			Mpupload.queue[id].crop.w = h > attr.oh ? attr.oh : w;
			Mpupload.queue[id].crop.h = h > attr.oh ? attr.oh : h;
			//  xy坐标暂时没测出什么问题
			Mpupload.queue[id].crop.x = x;
			Mpupload.queue[id].crop.y = y;

			var rx = 50 / cood.w,
			ry = 50 / cood.h;

			$(".photo-reel-photo[data-pid="+id+"] img").css({
				width: Math.round(rx * attr.rw) + 'px',
				height: Math.round(ry * attr.rh) + 'px',
				marginLeft: '-' + Math.round(rx * cood.x) + 'px',
				marginTop: '-' + Math.round(ry * cood.y) + 'px'
			});
		};
	};
});