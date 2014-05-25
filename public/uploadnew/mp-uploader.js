// http://www.zhangxinxu.com/wordpress/2011/02/html5-drag-drop-%E6%8B%96%E6%8B%BD%E4%B8%8E%E6%8B%96%E6%94%BE%E7%AE%80%E4%BB%8B/
// DataTransfer 对象：退拽对象用来传递的媒介，使用一般为Event.dataTransfer。
// draggable 属性：就是标签元素要设置draggable=true，否则不会有效果
// ondragstart 事件：当拖拽元素开始被拖拽的时候触发的事件，此事件作用在被拖曳元素上
// ondragenter 事件：当拖曳元素进入目标元素的时候触发的事件，此事件作用在目标元素上
// ondragover 事件：拖拽元素在目标元素上移动的时候触发的事件，此事件作用在目标元素上
// ondrop 事件：被拖拽的元素在目标元素上同时鼠标放开触发的事件，此事件作用在目标元素上
// ondragend 事件：当拖拽完成后触发的事件，此事件作用在被拖曳元素上
// Event.preventDefault() 方法：阻止默认的些事件方法等执行。在ondragover中一定要执行preventDefault()，否则ondrop事件不会被触发。另外，如果是从其他应用软件或是文件中拖东西进来，尤其是图片的时候，默认的动作是显示这个图片或是相关信息，并不是真的执行drop。此时需要用用document的ondragover事件把它直接干掉。
// Event.effectAllowed 属性：就是拖拽的效果
function Mpuploader(element, options){

};

// Mpuploader.ADDED = "added";
// Mpuploader.QUEUED = "queued";
// Mpuploader.ACCEPTED = Mpuploader.QUEUED;
// Mpuploader.UPLOADING = "uploading";
// Mpuploader.PROCESSING = Mpuploader.UPLOADING;
// Mpuploader.CANCELED = "canceled";
// Mpuploader.ERROR = "error";
// Mpuploader.SUCCESS = "success";
// 队列的初始值
Mpuploader.prototype.index = 0;
// 当前是哪个文件
Mpuploader.prototype.current = 0;
// 是否已存在活动
Mpuploader.prototype.exists_request = true;
// 是否已存在相册
Mpuploader.prototype.exists_album   = true;
// 队列
Mpuploader.prototype.queue = [];
Mpuploader.prototype.state  = '';

Mpuploader.prototype.init = function(){
	// 删除本张时借用pid 就不用一次次创建hiddeninput了
	this.hiddenFileInput = document.createElement("input");
	this.hiddenFileInput.setAttribute("type", "file");
	this.hiddenFileInput.setAttribute("multiple", "multiple");
	this.hiddenFileInput.className = "mpdz-hidden-input " + Math.random();
	this.hiddenFileInput.setAttribute("accept", 'image/*');
	this.hiddenFileInput.style.visibility = "hidden";
	this.hiddenFileInput.style.position = "absolute";
	this.hiddenFileInput.style.top = "0";
	this.hiddenFileInput.style.left = "0";
	this.hiddenFileInput.style.height = "0";
	this.hiddenFileInput.style.width = "0";
	document.body.appendChild(this.hiddenFileInput);
	this.hiddenFileInput.addEventListener("change", (function(_this){
		var file, files, _i, _len;
		files = _this.hiddenFileInput.files;
		if (files.length) {
			for (_i = 0, _len = files.length; _i < _len; _i++) {
				file = files[_i];
				_this.addFile(file);
			}
		}
	})(this));
}