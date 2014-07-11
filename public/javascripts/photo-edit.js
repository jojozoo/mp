$(function(){
	// 初始化
	Mpupload = {
		queue: {}
	};
	function init(){
		var clone = $(".edit-container").clone();
		Mpupload.details = clone.find("[disabled]").removeAttr("disabled").end().find("input[type=text], textarea").val("").end().find(".disabled").removeClass("disabled").end().html();
		for(var index in photos){
			var _photo = photos[index],
				_details = Mpupload.details.replace(/\{\{id\}\}/ig, function(word){
				return _photo.id;
			}),
				details = $(_details).appendTo(".edit-container").removeClass("disabled active").attr("data-pid", _photo.id);
			for(var key in _photo.exif){
				var v = _photo.exif[key];
				details.find("#photo-" + _photo.id + "-exif-" + key).val(v);
			}
			$("#photo-"+_photo.id+"-title").val(_photo.title);
			$("#photo-"+_photo.id+"-desc").val(_photo.desc);
			$("#photo-"+_photo.id+"-request_id option[value="+_photo.event_id+"]").attr("selected","true");
			$("#photo-"+_photo.id+"-album_id option[value="+_photo.album_id+"]").attr("selected","true");
			$("#photo-"+_photo.id+"-warrant"+_photo.warrant).click();
			for(var index in _photo.tags){
				details.find('.tag-textfield input').val(_photo.tags[index] + ",").keydown();
			}
			Mpupload.queue[_photo.id] = _photo;
			// initMap(_photo.id, _photo.exif.lat, _photo.exif.lon);
		}
		$(".photo-reel-photo.selected").click();
	}
	// 初始化 end 

	// 选择活动
	$(document).on("change", ".mpchooserequest", function(){
		var val = $(this).val(),
			w = $($('<div />')).html(Mpupload.details);
		Mpupload.details = w.find(".mpchooserequest option[value='"+ val +"']").attr("selected", true).end().html();
		$(".mpchooserequest option[value='"+ val +"']").attr("selected", true);
	});
	// 选择活动 end

	// 点击小图选择
	$(document).on("click", ".photo-reel-photo", function(){
		if($(".photo-reel-photo").length > 12){
			var current = $(this).index();
			if(current < 5){
				current = 5;
			}
			if(current > ($(".photo-reel-photo").length - 7)){
				current = $(".photo-reel-photo").length - 7;
			}
			$(".photos").css("left", -(current - 5) * 55);
		}

		$(this).addClass("selected").siblings().removeClass("selected");
		var pid = $(this).data('pid');
		if($("#GDMAP-"+pid).hasClass("amap-container")){
		} else {
			initMap(pid, Mpupload.queue[pid].exif.lat, Mpupload.queue[pid].exif.lon);
		};
		if($(".photo-preview[data-pid=" + pid + "] .jcrop-holder").length > 0){
		} else {
			initCrop(pid);
		};
		

		$(".photo-preview[data-pid="+pid+"]").removeClass("inactive").siblings().addClass("inactive");
		$(".photo-details[data-pid="+pid+"]").addClass("active").siblings().removeClass("active");
	});
	// 点击小图选择 end
	 
	// 删除本张
	$(document).on("click", "a.button.delete", function(){
		var _this = $(".photo-reel-photo.selected");
		if(_this.length > 0){
			var pid = _this.data("pid");
			if(confirm("确定删除本张?\n此操作不可恢复!")){
				// 删除本张
				$.post('/ajax/del/photo/' + pid, '', function(result){
					MPMSG(result.type, result.text);
				});
				// delete Mpupload.queue[pid];
				_this.prev().click();
				if(_this.next()){
					_this.next().click();
				} else if(_this.prev()){
					_this.prev().click();
				} else if($(".photo-reel-photo").length > 0){
					$(".photo-reel-photo:last").click();
				} else {
					$(".photo-details.disabled").addClass("active");
				}
				$("div[data-pid="+pid+"]").remove();
			}
			return;
		}

	});
	// 删除本张 end

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
				event.returnValue = false;
				event.cancel = true;
				return;
			}
			var str = '<div class="tag"><div class="name">'+ val +'</div><div class="remove">×</div></div>';
			var _width = $(this).width(),
			_jk    = $(this).parent().before(str).prev().width(),
			_rw    = (_width - _jk) < 170 ? 170 : (_width - _jk);
			$(this).val('').css({width: _rw});
			event.returnValue = false;
			event.cancel = true;
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
	});
	// 删除标签 end
	// 初始化地图 这里的地图不居中
	function initMap(id, lat, lon){
		// 应该点击移动到点击位置
		var mapObj,
			param = {};
		if(lat && lon){
			param = {center: new AMap.LngLat(lon, lat), level: 10};
		}
		mapObj = new AMap.Map("GDMAP-" + id, param);
		var marker = new AMap.Marker({
			position: mapObj.getCenter(),
			draggable:true, //点标记可拖拽
			cursor:'move',  //鼠标悬停点标记时的鼠标样式
			raiseOnDrag:true, //鼠标拖拽点标记时开启点标记离开地图的效果
			title: '坐标不正确?可自行拖拽到正确的拍摄地点.'
		});
		// 移动光标获取坐标事件
		var moveIconListener = AMap.event.addListener(marker, 'dragend', function(e){
			Mpupload.queue[id].exif.lat = e.lnglat.lat;
			Mpupload.queue[id].exif.lon = e.lnglat.lng;
		});
		// 点击地图某一点,icon移动并获取坐标事件
		var clickIconListener = AMap.event.addListener(mapObj,'click',function(e){
			var newPo = {j: e.lnglat.getLat(), l: e.lnglat.getLng()};
			marker.setPosition(newPo);
			Mpupload.queue[id].exif.lat = newPo.j;
			Mpupload.queue[id].exif.lon = newPo.l;
		});

		marker.setMap(mapObj);
	};
	// 初始化地图 end

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
			Mpupload.queue[id].crop.x = x; // xy坐标暂时没测出什么问题
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


	init();
})