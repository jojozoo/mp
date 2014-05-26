// // http://www.zhangxinxu.com/wordpress/2011/02/html5-drag-drop-%E6%8B%96%E6%8B%BD%E4%B8%8E%E6%8B%96%E6%94%BE%E7%AE%80%E4%BB%8B/
// // DataTransfer 对象：退拽对象用来传递的媒介，使用一般为Event.dataTransfer。
// // draggable 属性：就是标签元素要设置draggable=true，否则不会有效果
// // ondragstart 事件：当拖拽元素开始被拖拽的时候触发的事件，此事件作用在被拖曳元素上
// // ondragenter 事件：当拖曳元素进入目标元素的时候触发的事件，此事件作用在目标元素上
// // ondragover 事件：拖拽元素在目标元素上移动的时候触发的事件，此事件作用在目标元素上
// // ondrop 事件：被拖拽的元素在目标元素上同时鼠标放开触发的事件，此事件作用在目标元素上
// // ondragend 事件：当拖拽完成后触发的事件，此事件作用在被拖曳元素上
// // Event.preventDefault() 方法：阻止默认的些事件方法等执行。在ondragover中一定要执行preventDefault()，否则ondrop事件不会被触发。另外，如果是从其他应用软件或是文件中拖东西进来，尤其是图片的时候，默认的动作是显示这个图片或是相关信息，并不是真的执行drop。此时需要用用document的ondragover事件把它直接干掉。
// // Event.effectAllowed 属性：就是拖拽的效果
;(function(){

	/**
	 * Require the module at `name`.
	 *
	 * @param {String} name
	 * @return {Object} exports
	 * @api public
	 */

	function require(name) {
		var module = require.modules[name];
		if (!module) throw new Error('failed to require "' + name + '"');

		if (!('exports' in module) && typeof module.definition === 'function') {
			module.client = module.component = true;
			module.definition.call(this, module.exports = {}, module);
			delete module.definition;
		}

		return module.exports;
	}

	/**
	 * Registered modules.
	 */

	require.modules = {};

	/**
	 * Register module at `name` with callback `definition`.
	 *
	 * @param {String} name
	 * @param {Function} definition
	 * @api private
	 */

	require.register = function (name, definition) {
		require.modules[name] = {
			definition: definition
		};
	};

	/**
	 * Define a module's exports immediately with `exports`.
	 *
	 * @param {String} name
	 * @param {Generic} exports
	 * @api private
	 */

	require.define = function (name, exports) {
		require.modules[name] = {
			exports: exports
		};
	};
	require.register("component~emitter@1.1.2", function (exports, module) {

	/**
	 * Expose `Emitter`.
	 */

	module.exports = Emitter;

	/**
	 * Initialize a new `Emitter`.
	 *
	 * @api public
	 */

	function Emitter(obj) {
		if (obj) return mixin(obj);
	};

	/**
	 * Mixin the emitter properties.
	 *
	 * @param {Object} obj
	 * @return {Object}
	 * @api private
	 */

	function mixin(obj) {
		for (var key in Emitter.prototype) {
			obj[key] = Emitter.prototype[key];
		}
		return obj;
	}

	/**
	 * Listen on the given `event` with `fn`.
	 *
	 * @param {String} event
	 * @param {Function} fn
	 * @return {Emitter}
	 * @api public
	 */

	Emitter.prototype.on =
	Emitter.prototype.addEventListener = function(event, fn){
		this._callbacks = this._callbacks || {};
		(this._callbacks[event] = this._callbacks[event] || [])
			.push(fn);
		return this;
	};

	/**
	 * Adds an `event` listener that will be invoked a single
	 * time then automatically removed.
	 *
	 * @param {String} event
	 * @param {Function} fn
	 * @return {Emitter}
	 * @api public
	 */

	Emitter.prototype.once = function(event, fn){
		var self = this;
		this._callbacks = this._callbacks || {};

		function on() {
			self.off(event, on);
			fn.apply(this, arguments);
		}

		on.fn = fn;
		this.on(event, on);
		return this;
	};

	/**
	 * Remove the given callback for `event` or all
	 * registered callbacks.
	 *
	 * @param {String} event
	 * @param {Function} fn
	 * @return {Emitter}
	 * @api public
	 */

	Emitter.prototype.off =
	Emitter.prototype.removeListener =
	Emitter.prototype.removeAllListeners =
	Emitter.prototype.removeEventListener = function(event, fn){
		this._callbacks = this._callbacks || {};

		// all
		if (0 == arguments.length) {
			this._callbacks = {};
			return this;
		}

		// specific event
		var callbacks = this._callbacks[event];
		if (!callbacks) return this;

		// remove all handlers
		if (1 == arguments.length) {
			delete this._callbacks[event];
			return this;
		}

		// remove specific handler
		var cb;
		for (var i = 0; i < callbacks.length; i++) {
			cb = callbacks[i];
			if (cb === fn || cb.fn === fn) {
				callbacks.splice(i, 1);
				break;
			}
		}
		return this;
	};

	/**
	 * Emit `event` with the given args.
	 *
	 * @param {String} event
	 * @param {Mixed} ...
	 * @return {Emitter}
	 */

	Emitter.prototype.emit = function(event){
		this._callbacks = this._callbacks || {};
		var args = [].slice.call(arguments, 1)
			, callbacks = this._callbacks[event];

		if (callbacks) {
			callbacks = callbacks.slice(0);
			for (var i = 0, len = callbacks.length; i < len; ++i) {
				callbacks[i].apply(this, args);
			}
		}

		return this;
	};

	/**
	 * Return array of callbacks for `event`.
	 *
	 * @param {String} event
	 * @return {Array}
	 * @api public
	 */

	Emitter.prototype.listeners = function(event){
		this._callbacks = this._callbacks || {};
		return this._callbacks[event] || [];
	};

	/**
	 * Check if this emitter has `event` handlers.
	 *
	 * @param {String} event
	 * @return {Boolean}
	 * @api public
	 */

	Emitter.prototype.hasListeners = function(event){
		return !! this.listeners(event).length;
	};

	});

	require.register("dropzone", function (exports, module) {


	/**
	 * Exposing dropzone
	 */
	module.exports = require("dropzone/lib/dropzone.js");

	});

	require.register("dropzone/lib/dropzone.js", function (exports, module) {

	/*
	 *
	 * More info at [www.dropzonejs.com](http://www.dropzonejs.com)
	 *
	 * Copyright (c) 2012, Matias Meno
	 *
	 * Permission is hereby granted, free of charge, to any person obtaining a copy
	 * of this software and associated documentation files (the "Software"), to deal
	 * in the Software without restriction, including without limitation the rights
	 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
	 * copies of the Software, and to permit persons to whom the Software is
	 * furnished to do so, subject to the following conditions:
	 *
	 * The above copyright notice and this permission notice shall be included in
	 * all copies or substantial portions of the Software.
	 *
	 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
	 * THE SOFTWARE.
	 *
	 */

	(function() {
		var Dropzone, Em, camelize, contentLoaded, detectVerticalSquash, drawImageIOSFix, noop, without,
			__hasProp = {}.hasOwnProperty,
			__extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
			__slice = [].slice;

		Em = typeof Emitter !== "undefined" && Emitter !== null ? Emitter : require("component~emitter@1.1.2");

		noop = function() {};

		Dropzone = (function(_super) {
			var extend;

			__extends(Dropzone, _super);


			/*
			This is a list of all available events you can register on a dropzone object.
			
			You can register an event handler like this:
			
					dropzone.on("dragEnter", function() { });
			 */

			Dropzone.prototype.events = ["drop", "dragstart", "dragend", "dragenter", "dragover", "dragleave", "addedfile", "removedfile", "thumbnail", "large", "error", "errormultiple", "processing", "processingmultiple", "uploadprogress", "totaluploadprogress", "sending", "sendingmultiple", "success", "successmultiple", "canceled", "canceledmultiple", "complete", "completemultiple", "reset", "maxfilesexceeded", "maxfilesreached"];

			Dropzone.prototype.defaultOptions = {
				url: null,
				method: "post",
				withCredentials: false,
				parallelUploads: 2,
				uploadMultiple: false,
				paramName: "file",
				// createImageThumbnails: true, // 是否创建缩略图
				maxThumbnailFilesize: 10, // 当文件超过10M就不创建缩略图
				thumbnailWidth: 70,
				thumbnailHeight: 70, // 缩略图宽高
				largeMinHeight: 700, // 预览最小高度
				maxFiles: 2,
				params: {},
				clickable: true, // 如果 true,dropzone元素本身将是可点击的,如果false什么都不会被点击。否则,你可以通过一个HTML元素,一个CSS选择器(用于多个元素)或数组。
				ignoreHiddenFiles: true,
				acceptedFiles: 'image/*', // 指明允许上传的文件类型，格式是逗号分隔的 MIME type 或者扩展名。例如：image/*,application/pdf,.psd,.obj
				// acceptedMimeTypes: null, // 官方将要舍弃
				autoProcessQueue: true,
				// autoQueue: true, // 自动进入队列
				addRemoveLinks: true,	// 是否显示删除本张链接 默认false
				// dictDefaultMessage: "文件拖放此处上传",
				dictFallbackText: "请使用下面的备用形式上传您的文件.",
				maxFilesize: 10,
				dictFileTooBig: "文件过大 ({{filesize}}MB). 最大: {{maxFilesize}}MB.",
				dictInvalidFileType: "你不能上传文件的类型.",
				dictResponseError: "Server responded with {{statusCode}} code.",
				dictCancelUpload: "取消上传",
				dictCancelUploadConfirmation: "确定要取消上传?",
				dictRemoveFile: "删除本张",
				// dictRemoveFileConfirmation: null, // 如果addRemoveLinks是真的,文本用于确认当取消上传 去掉本选项
				dictMaxFilesExceeded: "不能再上传文件.",
				largeContainer: ".active-photo",
				largeTemplate: "<div class='photo-preview inactive'><img src=''></div>",
				thumbContainer: ".photos",
				thumbTemplate: "<div class='photo-reel-photo' data-pid=''><img width='50' height='50'></img></div>",
				accept: function(file, done) {
					return done();
				},
				init: function() {
					return noop;
				},
				// forceFallback: true,
				fallback: function() {
					// 不支持拖拽的回调函数
					var messageElement = document.querySelector(".browser-not-supported");
					messageElement.innerHTML = "您的浏览器不支持拖拽上传，您可以使用我们推荐的浏览器，请点击<a target='_blank' href='javascript:void(0);'>这里</a><br>或者点击上传照片按钮进行上传";
					// return this.element.appendChild(this.getFallbackForm());
				},
				largeresize: function(file){
					// 按比例或者规定比例缩放 大图缩略图最高700
					// 这个是预览图 不应该是正方形
					// largeMinHeight = 700
					var info, srcRatio, trgRatio;
					info = {
						srcX: 0,
						srcY: 0,
						srcWidth: file.width,
						srcHeight: file.height
					};
					srcRatio = file.width / file.height;
					info.optHeight = this.options.largeMinHeight;
					info.optWidth  = srcRatio * info.optHeight;
					trgRatio = info.optWidth / info.optHeight;
					if (file.height < info.optHeight || file.width < info.optWidth) {
						info.trgHeight = info.srcHeight;
						info.trgWidth = info.srcWidth;
					} else {
						if (srcRatio > trgRatio) {
							info.srcHeight = file.height;
							info.srcWidth = info.srcHeight * trgRatio;
						} else {
							info.srcWidth = file.width;
							info.srcHeight = info.srcWidth / trgRatio;
						}
					}
					info.srcX = (file.width - info.srcWidth) / 2;
					info.srcY = (file.height - info.srcHeight) / 2;
					return info;

				},
				resize: function(file) {

					var info, srcRatio, trgRatio;
					info = {
						srcX: 0,
						srcY: 0,
						srcWidth: file.width,
						srcHeight: file.height
					};
					srcRatio = file.width / file.height;
					info.optWidth = this.options.thumbnailWidth;
					info.optHeight = this.options.thumbnailHeight;
					if ((info.optWidth == null) && (info.optHeight == null)) {
						info.optWidth = info.srcWidth;
						info.optHeight = info.srcHeight;
					} else if (info.optWidth == null) {
						info.optWidth = srcRatio * info.optHeight;
					} else if (info.optHeight == null) {
						info.optHeight = (1 / srcRatio) * info.optWidth;
					}
					trgRatio = info.optWidth / info.optHeight;
					if (file.height < info.optHeight || file.width < info.optWidth) {
						info.trgHeight = info.srcHeight;
						info.trgWidth = info.srcWidth;
					} else {
						if (srcRatio > trgRatio) {
							info.srcHeight = file.height;
							info.srcWidth = info.srcHeight * trgRatio;
						} else {
							info.srcWidth = file.width;
							info.srcHeight = info.srcWidth / trgRatio;
						}
					}
					info.srcX = (file.width - info.srcWidth) / 2;
					info.srcY = (file.height - info.srcHeight) / 2;
					return info;
				},
				drop: function(e) {
					return this.element.classList.remove("mpdz-drag-hover");
				},
				dragstart: noop,
				dragend: function(e) {
					return this.element.classList.remove("mpdz-drag-hover");
				},
				dragenter: function(e) {
					return this.element.classList.add("mpdz-drag-hover");
				},
				dragover: function(e) {
					return this.element.classList.add("mpdz-drag-hover");
				},
				dragleave: function(e) {
					return this.element.classList.remove("mpdz-drag-hover");
				},
				paste: noop,
				reset: function() {
					return this.element.classList.remove("mpdz-started");
				},
				addedfile: function(file) {
					// TODO 暂时不要删除 等完善了删除本张的方法后
					// var node, removeFileEvent, removeLink, _i, _j, _k, _len, _len1, _len2, _ref, _ref1, _ref2, _results;
					// removeFileEvent = (function(_this) {
					// 	return function(e) {
					// 		e.preventDefault();
					// 		e.stopPropagation();
					// 		if (window.confirm('您确定要删除这张照片？')) {
					// 			return _this.removeFile(file);
					// 		};
					// 	};
					// })(this);
					// _results = [];
					// removeLink = document.getElementsByClassName("remove")[0];
					// _results.push(removeLink.addEventListener("click", removeFileEvent));
					// return _results;
				},
				removedfile: function(file) {
					var _ref;
					if (file.largeElement) {
						if ((_ref = file.largeElement) != null) {
							_ref.parentNode.removeChild(file.largeElement);
						}
					}
					return this._updateMaxFilesReachedClass();
				},
				thumbnail: function(file, dataUrl, islast) {
					// 查找最后一条，此处应该有pid,方便查找
					var thumbnailElement = file.thumbElement.querySelectorAll("img")[0];
					thumbnailElement.alt = file.name;
					thumbnailElement.src = dataUrl;
					if(islast){
						file.thumbElement.className = 'photo-reel-photo selected';
					}
				},
				large: function(file, dataUrl, islast){
					var largeElement = file.largeElement.querySelectorAll("img")[0];
					largeElement.alt = file.name;
					largeElement.src = dataUrl;
					if(islast){
						file.largeElement.className = 'photo-preview';
					}
				},
				error: function(file, message) {
					var node, _i, _len, _ref, _results;
					if (file.largeElement) {
						file.largeElement.classList.add("mpdz-error");
						if (typeof message !== "String" && message.error) {
							message = message.error;
						}
						_ref = file.largeElement.querySelectorAll("[data-mpdz-errormessage]");
						_results = [];
						for (_i = 0, _len = _ref.length; _i < _len; _i++) {
							node = _ref[_i];
							_results.push(node.textContent = message);
						}
						return _results;
					}
				},
				errormultiple: noop,
				processing: function(file) {
					if (file.largeElement) {
						file.largeElement.classList.add("mpdz-processing");
						if (file._removeLink) {
							return file._removeLink.textContent = this.options.dictCancelUpload;
						}
					}
				},
				processingmultiple: noop,
				uploadprogress: function(file, progress, bytesSent) {
					var node, _i, _len, _ref, _results;
					if (file.largeElement) {
						_ref = file.largeElement.querySelectorAll("[data-mpdz-uploadprogress]");
						_results = [];
						for (_i = 0, _len = _ref.length; _i < _len; _i++) {
							node = _ref[_i];
							_results.push(node.style.width = "" + progress + "%");
						}
						return _results;
					}
				},
				totaluploadprogress: noop,
				sending: noop,
				sendingmultiple: noop,
				success: function(file) {
					if (file.largeElement) {
						return file.largeElement.classList.add("mpdz-success");
					}
				},
				successmultiple: noop,
				canceled: function(file) {
					return this.emit("error", file, "Upload canceled.");
				},
				canceledmultiple: noop,
				complete: function(file) {
					if (file._removeLink) {
						return file._removeLink.textContent = this.options.dictRemoveFile;
					}
				},
				completemultiple: noop,
				maxfilesexceeded: noop,
				maxfilesreached: noop
			};
			// defaultOptions end

			// 此函数类似 merge
			extend = function() {
				var key, object, objects, target, val, _i, _len;
				target = arguments[0], objects = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
				for (_i = 0, _len = objects.length; _i < _len; _i++) {
					object = objects[_i];
					for (key in object) {
						val = object[key];
						target[key] = val;
					}
				}
				return target;
			};

			function Dropzone(element, options) {
				var elementOptions, fallback, _ref;
				this.element = element;
				this.listeners = [];
				this.files = [];
				Dropzone.instances.push(this);
				this.element.dropzone = this;
				elementOptions = (_ref = Dropzone.optionsForElement(this.element)) != null ? _ref : {};
				// 设置options 只需要一次设置即可
				this.options = extend({}, this.defaultOptions, elementOptions, options != null ? options : {});
				// if (this.options.forceFallback || !Dropzone.isBrowserSupported()) {
				if (!Dropzone.isBrowserSupported()) {
					// Fallback 是一种机制，当浏览器不支持此插件时，提供一个备选方案。默认为false。如果设为true，则强制 fallback。
					return this.options.fallback.call(this);
				}
				this.largeContainer = document.querySelector(this.options.largeContainer);
				this.thumbContainer = document.querySelector(this.options.thumbContainer);
				this.init();
			}

			Dropzone.prototype.init = function() {
				var eventName, noPropagation, _i, _len, _ref, _events;
				// 给hiddenFileInput添加单击上传事件
				this.clickHiddenFileInput();
				
				// TODO 干嘛用的?
				this.URL = (_ref = window.URL) != null ? _ref : window.webkitURL;
				_events = this.events;
				for (_i = 0, _len = _events.length; _i < _len; _i++) {
					eventName = _events[_i];
					this.on(eventName, this.options[eventName]);
				}
				this.on("uploadprogress", (function(_this) {
					return function() {
						return _this.updateTotalUploadProgress();
					};
				})(this));
				this.on("removedfile", (function(_this) {
					return function() {
						return _this.updateTotalUploadProgress();
					};
				})(this));
				this.on("canceled", (function(_this) {
					return function(file) {
						return _this.emit("complete", file);
					};
				})(this));
				this.on("complete", (function(_this) {
					return function(file) {
						if (_this.getUploadingFiles().length === 0 && _this.getQueuedFiles().length === 0) {
							return setTimeout((function() {
								return _this.emit("queuecomplete");
							}), 0);
						}
					};
				})(this));
				// drop事件中要用e.stopPropagation()阻止浏览器默认事件
				// 在IE中可以用e.cancelBubble = true
				noPropagation = function(e) {
					if(e.stopPropagation){
						e.stopPropagation();
					} else {
						e.cancelBubble = true;
					}
					if (e.preventDefault) {
						// 当拖动链接等有默认事件的元素时，要在dragover事件中用e.preventDefault()阻止默认事件。否则drop事件不会触发。
						return e.preventDefault();
					} else {
						// 在IE中可以用e.returnValue = false
						return e.returnValue = false;
					}
				};
				this.listeners = [
					{
						element: this.element,
						events: {
							"dragstart": (function(_this) {
								return function(e) {
									return _this.emit("dragstart", e);
								};
							})(this),
							"dragenter": (function(_this) {
								return function(e) {
									noPropagation(e);
									return _this.emit("dragenter", e);
								};
							})(this),
							"dragover": (function(_this) {
								// 在被拖放在某元素内移动时触发
								// effectAllowed拖拽的效果
								return function(e) {
									// http://www.html5jscss.com/html-5-drag-drop.html
									// 如果浏览器内的拖动 那么应该用move 浏览器外的用move也不会删除掉
									var efct;
									try {
										efct = e.dataTransfer.effectAllowed;
									} catch (_error) {}
									e.dataTransfer.dropEffect = 'move' === efct || 'linkMove' === efct ? 'move' : 'copy';
									noPropagation(e);
									return _this.emit("dragover", e);
								};
							})(this),
							"dragleave": (function(_this) {
								return function(e) {
									return _this.emit("dragleave", e);
								};
							})(this),
							"drop": (function(_this) {
								return function(e) {
									noPropagation(e);
									// 此处调用的是Dropzone.prototype.drop函数
									return _this.drop(e);
								};
							})(this),
							"dragend": (function(_this) {
								return function(e) {
									return _this.emit("dragend", e);
								};
							})(this)
						}
					}
				];

				this.uprmjxfi();
				this.handlerEventListeners('add');
				return this.options.init.call(this);
			};
			// init end

			// TODO 会分为上传照片 删除本张 继续上传 完成上传 点击事件的初始化 都要在init里面去完成
			Dropzone.prototype.uprmjxfi = function(){
				var droplink, _this;
				droplink = document.getElementsByClassName('droplink')[0];
				_this = this;
				this.listeners.push({
					element: droplink,
					events: {
						"click": function() {
								return _this.hiddenFileInput.click();
						}
					}
				});
			};

			Dropzone.prototype.clickHiddenFileInput = function(){
				if (this.hiddenFileInput) {
					document.body.removeChild(this.hiddenFileInput);
				}
				this.hiddenFileInput = document.createElement("input");
				this.hiddenFileInput.setAttribute("type", "file");
				this.hiddenFileInput.setAttribute("multiple", "multiple");
				this.hiddenFileInput.className = "" + Math.random();
				this.hiddenFileInput.setAttribute("accept", this.options.acceptedFiles);
				this.hiddenFileInput.style.visibility = "hidden";
				this.hiddenFileInput.style.position = "absolute";
				this.hiddenFileInput.style.top = "0";
				this.hiddenFileInput.style.left = "0";
				this.hiddenFileInput.style.height = "0";
				this.hiddenFileInput.style.width = "0";
				document.body.appendChild(this.hiddenFileInput);
				// 给input添加change事件
				return (function(_this){
					_this.hiddenFileInput.addEventListener("change", function() {
						var file, files, _i, _len;
						files = _this.hiddenFileInput.files;
						if (files.length) {
							for (_i = 0, _len = files.length; _i < _len; _i++) {
								file = files[_i];
								_this.addFile(file);
							}
						}
					});
				})(this);
				// var _this = this;
				// this.hiddenFileInput.addEventListener("change", function() {
				// 	var file, files, _i, _len;
				// 	files = _this.hiddenFileInput.files;
				// 	if (files.length) {
				// 		for (_i = 0, _len = files.length; _i < _len; _i++) {
				// 			file = files[_i];
				// 			_this.addFile(file);
				// 		}
				// 	}
				// });
			};

			// 获取总的文件数量
			Dropzone.prototype.getAcceptedFiles = function() {
				var file, _i, _len, _ref, _results;
				_ref = this.files;
				_results = [];
				for (_i = 0, _len = _ref.length; _i < _len; _i++) {
					file = _ref[_i];
					if (file.accepted) {
						_results.push(file);
					}
				}
				return _results;
			};

			Dropzone.prototype.getRejectedFiles = function() {
				var file, _i, _len, _ref, _results;
				_ref = this.files;
				_results = [];
				for (_i = 0, _len = _ref.length; _i < _len; _i++) {
					file = _ref[_i];
					if (!file.accepted) {
						_results.push(file);
					}
				}
				return _results;
			};

			Dropzone.prototype.getFilesWithStatus = function(status) {
				var file, _i, _len, _ref, _results;
				_ref = this.files;
				_results = [];
				for (_i = 0, _len = _ref.length; _i < _len; _i++) {
					file = _ref[_i];
					if (file.status === status) {
						_results.push(file);
					}
				}
				return _results;
			};

			Dropzone.prototype.getQueuedFiles = function() {
				return this.getFilesWithStatus(Dropzone.QUEUED);
			};

			Dropzone.prototype.getUploadingFiles = function() {
				return this.getFilesWithStatus(Dropzone.UPLOADING);
			};

			Dropzone.prototype.getActiveFiles = function() {
				var file, _i, _len, _ref, _results;
				_ref = this.files;
				_results = [];
				for (_i = 0, _len = _ref.length; _i < _len; _i++) {
					file = _ref[_i];
					if (file.status === Dropzone.UPLOADING || file.status === Dropzone.QUEUED) {
						_results.push(file);
					}
				}
				return _results;
			};

			// 这是什么 在哪用到
			Dropzone.prototype.updateTotalUploadProgress = function() {
				var activeFiles, file, totalBytes, totalBytesSent, totalUploadProgress, _i, _len, _ref;
				totalBytesSent = 0;
				totalBytes = 0;
				activeFiles = this.getActiveFiles();
				if (activeFiles.length) {
					_ref = this.getActiveFiles();
					for (_i = 0, _len = _ref.length; _i < _len; _i++) {
						file = _ref[_i];
						totalBytesSent += file.upload.bytesSent;
						totalBytes += file.upload.total;
					}
					totalUploadProgress = 100 * totalBytesSent / totalBytes;
				} else {
					totalUploadProgress = 100;
				}
				return this.emit("totaluploadprogress", totalUploadProgress, totalBytes, totalBytesSent);
			};

			Dropzone.prototype._getParamName = function(n) {
				if (typeof this.options.paramName === "function") {
					return this.options.paramName(n);
				} else {
					return "" + this.options.paramName + (this.options.uploadMultiple ? "[" + n + "]" : "");
				}
			};

			// 移除或者增加监听事件 active-photo-wrap的7个事件和droplink的click事件
			// 合并了原来的setupEventListeners和removeEventListeners
			// handler是move或者add
			Dropzone.prototype.handlerEventListeners = function(handler){
				var _row, _event, _events, listener, _i, _len, _ref;
				_ref = this.listeners; // 需要监听的 在init函数里的this.listeners
				for (_i = 0, _len = _ref.length; _i < _len; _i++) {
					_row = _ref[_i];
					_events = _row.events;
					for (_event in _events) {
						listener = _events[_event];
						if(handler === 'move'){
							_row.element.removeEventListener(_event, listener, false);
						} else {
							_row.element.addEventListener(_event, listener, false);
						}
					}
				}
			}

			// // 停用
			// Dropzone.prototype.disable = function() {
			// 	var file, _i, _len, _ref, _results;
			// 	this.handlerEventListeners('move');
			// 	_ref = this.files;
			// 	_results = [];
			// 	for (_i = 0, _len = _ref.length; _i < _len; _i++) {
			// 		file = _ref[_i];
			// 		_results.push(this.cancelUpload(file));
			// 	}
			// 	return _results;
			// };

			Dropzone.prototype.filesize = function(size) {
				var string;
				if (size >= 1024 * 1024 * 1024 * 1024 / 10) {
					size = size / (1024 * 1024 * 1024 * 1024 / 10);
					string = "TB";
				} else if (size >= 1024 * 1024 * 1024 / 10) {
					size = size / (1024 * 1024 * 1024 / 10);
					string = "GB";
				} else if (size >= 1024 * 1024 / 10) {
					size = size / (1024 * 1024 / 10);
					string = "MB";
				} else if (size >= 1024 / 10) {
					size = size / (1024 / 10);
					string = "KB";
				} else {
					size = size * 10;
					string = "B";
				}
				return "<strong>" + (Math.round(size) / 10) + "</strong> " + string;
			};

			Dropzone.prototype._updateMaxFilesReachedClass = function() {
				if ((this.options.maxFiles != null) && this.getAcceptedFiles().length >= this.options.maxFiles) {
					if (this.getAcceptedFiles().length === this.options.maxFiles) {
						this.emit('maxfilesreached', this.files);
					}
					return this.element.classList.add("mpdz-max-files-reached");
				} else {
					return this.element.classList.remove("mpdz-max-files-reached");
				}
			};

			Dropzone.prototype.drop = function(e) {
				var files, items;
				// dataTransfer是拖拽中数据传输管道，如果没有值或者这个属性，说明拖拽失败，直接return
				if (!e.dataTransfer) {
					return;
				}
				this.emit("drop", e);
				// dataTransfer.files属性是一个类数组的File对象
				files = e.dataTransfer.files;

				// 如果拖动的是文本 那么此处会停止
				if (files.length) {
					// drop事件处理程序将能遍历dataTransfer.items[]的元素去检查文件和非文件数据。
					items = e.dataTransfer.items;
					// 添加文件夹时做的处理 暂时只chrome支持
					if (items && items.length && (items[0].webkitGetAsEntry != null)) {
						this._addFilesFromItems(items);
					} else {
						this.handleFiles(files);
					}
				}
			};

			// 暂时不知道哪个浏览器支持
			Dropzone.prototype.paste = function(e) {
				var items, _ref;
				if ((e != null ? (_ref = e.clipboardData) != null ? _ref.items : void 0 : void 0) == null) {
					return;
				}
				this.emit("paste", e);
				items = e.clipboardData.items;
				if (items.length) {
					return this._addFilesFromItems(items);
				}
			};

			// 遍历files逐一addFile 拖拽的一种添加方法
			Dropzone.prototype.handleFiles = function(files) {
				var file, _i, _len, _results;
				_results = [];
				for (_i = 0, _len = files.length; _i < _len; _i++) {
					file = files[_i];
					_results.push(this.addFile(file));
				}
				return _results;
			};

			// 添加文件夹时做的处理 暂时只chrome支持
			Dropzone.prototype._addFilesFromItems = function(items) {
				var entry, item, _i, _len, _results;
				_results = [];
				for (_i = 0, _len = items.length; _i < _len; _i++) {
					item = items[_i];
					if ((item.webkitGetAsEntry != null) && (entry = item.webkitGetAsEntry())) {
						if (entry.isFile) {
							_results.push(this.addFile(item.getAsFile()));
						} else if (entry.isDirectory) {
							// 如果是目录 继续下一步查找
							_results.push(this._addFilesFromDirectory(entry, entry.name));
						} else {
							_results.push(void 0);
						}
					} else if (item.getAsFile != null) {
						if ((item.kind == null) || item.kind === "file") {
							_results.push(this.addFile(item.getAsFile()));
						} else {
							_results.push(void 0);
						}
					} else {
						_results.push(void 0);
					}
				}
				return _results;
			};

			// 读取目录 只限chrome
			Dropzone.prototype._addFilesFromDirectory = function(directory, path) {
				var dirReader, entriesReader;
				dirReader = directory.createReader();
				entriesReader = (function(_this) {
					return function(entries) {
						var entry, _i, _len;
						for (_i = 0, _len = entries.length; _i < _len; _i++) {
							entry = entries[_i];
							if (entry.isFile) {
								entry.file(function(file) {
									if (_this.options.ignoreHiddenFiles && file.name.substring(0, 1) === '.') {
										return;
									}
									file.fullPath = "" + path + "/" + file.name;
									return _this.addFile(file);
								});
							} else if (entry.isDirectory) {
								_this._addFilesFromDirectory(entry, "" + path + "/" + entry.name);
							}
						}
					};
				})(this);
				return dirReader.readEntries(entriesReader, function(error) {
					return typeof console !== "undefined" && console !== null ? typeof console.log === "function" ? console.log(error) : void 0 : void 0;
				});
			};

			Dropzone.prototype.accept = function(file, done) {
				// 文件过大
				if (file.size > this.options.maxFilesize * 1024 * 1024) {
					return done(this.options.dictFileTooBig.replace("{{filesize}}", Math.round(file.size / 1024 / 10.24) / 100).replace("{{maxFilesize}}", this.options.maxFilesize));
				// 无效文件
				} else if (!Dropzone.isValidFile(file, this.options.acceptedFiles)) {
					return done(this.options.dictInvalidFileType);
				} else if ((this.options.maxFiles != null) && this.getAcceptedFiles().length >= this.options.maxFiles) {
					done(this.options.dictMaxFilesExceeded.replace("{{maxFiles}}", this.options.maxFiles));
					return this.emit("maxfilesexceeded", file);
				} else {
					return this.options.accept.call(this, file, done);
				}
			};

			// 添加文件
			Dropzone.prototype.addFile = function(file) {
				file.upload = {
					progress: 0,
					total: file.size,
					bytesSent: 0
				};
				this.files.push(file);
				file.status = Dropzone.ADDED;
				// this.emit("addedfile", file);
				
				return this.accept(file, (function(_this) {
					return function(error) {
						if (error) {
							file.accepted = false;
							_this._errorProcessing([file], error);
						} else {
							file.accepted = true;
							_this.enqueueFile(file);
						}
						return _this._updateMaxFilesReachedClass();
					};
				})(this));
			};

			// 进入队列的文件 enqueue入队
			Dropzone.prototype.enqueueFile = function(file) {
				if (file.status === Dropzone.ADDED && file.accepted === true) {
					// 只有进入队列才可以生成缩略图
					this._enqueueThumbnail(file);
					file.status = Dropzone.QUEUED;
					if (this.options.autoProcessQueue) {
						return setTimeout(((function(_this) {
							return function() {
								return _this.processQueue();
							};
						})(this)), 0);
					}
				} else {
					throw new Error("此文件无法进行排队，因为它已经被处理或被否决.");
				}
			};

			Dropzone.prototype._thumbnailQueue = [];

			Dropzone.prototype._processingThumbnail = false;

			// 缩略图队列 添加到队列
			Dropzone.prototype._enqueueThumbnail = function(file) {
				
				// // 大图处理
				// file.largeElement = Dropzone.createElement(this.options.largeTemplate.trim());
				// this.largeContainer.appendChild(file.largeElement);
				// // 缩略图的处理
				// file.thumbElement = Dropzone.createElement(this.options.thumbTemplate.trim());
				// this.thumbContainer.appendChild(file.thumbElement);
				// 配置创建缩略图为true并且类型匹配 并且文件小于配置最大数
				if (this.options.createImageThumbnails && file.type.match(/image.*/) && file.size <= this.options.maxThumbnailFilesize * 1024 * 1024) {
					this._thumbnailQueue.push(file);
					return setTimeout(((function(_this) {
						return function() {
							return _this._processThumbnailQueue();
						};
					})(this)), 0);
				}
			};

			// 创建缩略图
			Dropzone.prototype.createThumbnail = function(file, _shift, islast, callback) {
				var fileReader;
				fileReader = new FileReader;
				fileReader.onload = (function(_this) {
					return function() {
						var img;
						img = document.createElement("img");
						img.onload = function() {
							var canvas, ctx, resizeInfo, thumbnail, _ref, _ref1, _ref2, _ref3;
							file.width = img.width;
							file.height = img.height;
							if(_shift == 'large'){
								resizeInfo = _this.options.largeresize.call(_this, file);
							} else {
								resizeInfo = _this.options.resize.call(_this, file);
							}
							if (resizeInfo.trgWidth == null) {
								resizeInfo.trgWidth = resizeInfo.optWidth;
							}
							if (resizeInfo.trgHeight == null) {
								resizeInfo.trgHeight = resizeInfo.optHeight;
							}
							canvas = document.createElement("canvas");
							ctx = canvas.getContext("2d");
							canvas.width = resizeInfo.trgWidth;
							canvas.height = resizeInfo.trgHeight;
							// ie的支持参考 http://www.oschina.net/question/12_31182
							drawImageIOSFix(ctx, img, (_ref = resizeInfo.srcX) != null ? _ref : 0, (_ref1 = resizeInfo.srcY) != null ? _ref1 : 0, resizeInfo.srcWidth, resizeInfo.srcHeight, (_ref2 = resizeInfo.trgX) != null ? _ref2 : 0, (_ref3 = resizeInfo.trgY) != null ? _ref3 : 0, resizeInfo.trgWidth, resizeInfo.trgHeight);
							thumbnail = canvas.toDataURL("image/png");
							_this.emit(_shift, file, thumbnail, islast);
							if (callback != null) {
								return callback();
							}
						};
						return img.src = fileReader.result;
					};
				})(this);

				return fileReader.readAsDataURL(file);
			};

			// 进程队列的缩略图 创建缩略图
			Dropzone.prototype._processThumbnailQueue = function() {
				if (this._processingThumbnail || this._thumbnailQueue.length === 0) {
					return;
				}
				this._processingThumbnail = true;
				var _shift = this._thumbnailQueue.shift();
				var _last  = this._thumbnailQueue.length === 0;
				this.createThumbnail(_shift, 'large', _last, null);
				return this.createThumbnail(_shift, 'thumbnail', _last, (function(_this) {
					return function() {
						_this._processingThumbnail = false;
						return _this._processThumbnailQueue();
					};
				})(this));
			};

			Dropzone.prototype.removeFile = function(file) {
				if (file.status === Dropzone.UPLOADING) {
					this.cancelUpload(file);
				}
				this.files = without(this.files, file);
				this.emit("removedfile", file);
				if (this.files.length === 0) {
					return this.emit("reset");
				}
			};


			Dropzone.prototype.processQueue = function() {
				var i, parallelUploads, processingLength, queuedFiles;
				parallelUploads = this.options.parallelUploads;
				processingLength = this.getUploadingFiles().length;
				i = processingLength;
				if (processingLength >= parallelUploads) {
					return;
				}
				queuedFiles = this.getQueuedFiles();
				if (!(queuedFiles.length > 0)) {
					return;
				}
				if (this.options.uploadMultiple) {
					return this.processFiles(queuedFiles.slice(0, parallelUploads - processingLength));
				} else {
					while (i < parallelUploads) {
						if (!queuedFiles.length) {
							return;
						}
						this.processFile(queuedFiles.shift());
						i++;
					}
				}
			};

			Dropzone.prototype.processFile = function(file) {
				return this.processFiles([file]);
			};

			Dropzone.prototype.processFiles = function(files) {
				var file, _i, _len;
				for (_i = 0, _len = files.length; _i < _len; _i++) {
					file = files[_i];
					file.processing = true;
					file.status = Dropzone.UPLOADING;
					this.emit("processing", file);
				}
				if (this.options.uploadMultiple) {
					this.emit("processingmultiple", files);
				}
				return this.uploadFiles(files);
			};

			Dropzone.prototype._getFilesWithXhr = function(xhr) {
				var file, files;
				return files = (function() {
					var _i, _len, _ref, _results;
					_ref = this.files;
					_results = [];
					for (_i = 0, _len = _ref.length; _i < _len; _i++) {
						file = _ref[_i];
						if (file.xhr === xhr) {
							_results.push(file);
						}
					}
					return _results;
				}).call(this);
			};

			// 取消上传
			Dropzone.prototype.cancelUpload = function(file) {
				var groupedFile, groupedFiles, _i, _j, _len, _len1, _ref;
				if (file.status === Dropzone.UPLOADING) {
					groupedFiles = this._getFilesWithXhr(file.xhr);
					for (_i = 0, _len = groupedFiles.length; _i < _len; _i++) {
						groupedFile = groupedFiles[_i];
						groupedFile.status = Dropzone.CANCELED;
					}
					file.xhr.abort();
					for (_j = 0, _len1 = groupedFiles.length; _j < _len1; _j++) {
						groupedFile = groupedFiles[_j];
						this.emit("canceled", groupedFile);
					}
					if (this.options.uploadMultiple) {
						this.emit("canceledmultiple", groupedFiles);
					}
				} else if ((_ref = file.status) === Dropzone.ADDED || _ref === Dropzone.QUEUED) {
					file.status = Dropzone.CANCELED;
					this.emit("canceled", file);
					if (this.options.uploadMultiple) {
						this.emit("canceledmultiple", [file]);
					}
				}
				if (this.options.autoProcessQueue) {
					return this.processQueue();
				}
			};

			Dropzone.prototype.uploadFile = function(file) {
				return this.uploadFiles([file]);
			};

			// 上传
			Dropzone.prototype.uploadFiles = function(files) {
				var file, formData, handleError, headerName, headerValue, headers, i, input, inputName, inputType, key, option, progressObj, response, updateProgress, value, xhr, _i, _j, _k, _l, _len, _len1, _len2, _len3, _m, _ref, _ref1, _ref2, _ref3, _ref4, _ref5;
				xhr = new XMLHttpRequest();
				for (_i = 0, _len = files.length; _i < _len; _i++) {
					file = files[_i];
					file.xhr = xhr;
				}
				xhr.open(this.options.method, this.options.url, true);
				xhr.withCredentials = !!this.options.withCredentials;
				response = null;
				handleError = (function(_this) {
					return function() {
						var _j, _len1, _results;
						_results = [];
						for (_j = 0, _len1 = files.length; _j < _len1; _j++) {
							file = files[_j];
							_results.push(_this._errorProcessing(files, response || _this.options.dictResponseError.replace("{{statusCode}}", xhr.status), xhr));
						}
						return _results;
					};
				})(this);
				updateProgress = (function(_this) {
					return function(e) {
						var allFilesFinished, progress, _j, _k, _l, _len1, _len2, _len3, _results;
						if (e != null) {
							progress = 100 * e.loaded / e.total;
							for (_j = 0, _len1 = files.length; _j < _len1; _j++) {
								file = files[_j];
								file.upload = {
									progress: progress,
									total: e.total,
									bytesSent: e.loaded
								};
							}
						} else {
							allFilesFinished = true;
							progress = 100;
							for (_k = 0, _len2 = files.length; _k < _len2; _k++) {
								file = files[_k];
								if (!(file.upload.progress === 100 && file.upload.bytesSent === file.upload.total)) {
									allFilesFinished = false;
								}
								file.upload.progress = progress;
								file.upload.bytesSent = file.upload.total;
							}
							if (allFilesFinished) {
								return;
							}
						}
						_results = [];
						for (_l = 0, _len3 = files.length; _l < _len3; _l++) {
							file = files[_l];
							_results.push(_this.emit("uploadprogress", file, progress, file.upload.bytesSent));
						}
						return _results;
					};
				})(this);
				xhr.onload = (function(_this) {
					return function(e) {
						var _ref;
						if (files[0].status === Dropzone.CANCELED) {
							return;
						}
						if (xhr.readyState !== 4) {
							return;
						}
						response = xhr.responseText;
						if (xhr.getResponseHeader("content-type") && ~xhr.getResponseHeader("content-type").indexOf("application/json")) {
							try {
								response = JSON.parse(response);
							} catch (_error) {
								e = _error;
								response = "Invalid JSON response from server.";
							}
						}
						updateProgress();
						if (!((200 <= (_ref = xhr.status) && _ref < 300))) {
							return handleError();
						} else {
							return _this._finished(files, response, e);
						}
					};
				})(this);
				xhr.onerror = (function(_this) {
					return function() {
						if (files[0].status === Dropzone.CANCELED) {
							return;
						}
						return handleError();
					};
				})(this);
				progressObj = (_ref = xhr.upload) != null ? _ref : xhr;
				progressObj.onprogress = updateProgress;
				headers = {
					"Accept": "application/json",
					"Cache-Control": "no-cache",
					"X-Requested-With": "XMLHttpRequest"
				};
				if (this.options.headers) {
					extend(headers, this.options.headers);
				}
				for (headerName in headers) {
					headerValue = headers[headerName];
					xhr.setRequestHeader(headerName, headerValue);
				}
				formData = new FormData();
				if (this.options.params) {
					_ref1 = this.options.params;
					for (key in _ref1) {
						value = _ref1[key];
						formData.append(key, value);
					}
				}
				for (_j = 0, _len1 = files.length; _j < _len1; _j++) {
					file = files[_j];
					this.emit("sending", file, xhr, formData);
				}
				if (this.options.uploadMultiple) {
					this.emit("sendingmultiple", files, xhr, formData);
				}
				if (this.element.tagName === "FORM") {
					_ref2 = this.element.querySelectorAll("input, textarea, select, button");
					for (_k = 0, _len2 = _ref2.length; _k < _len2; _k++) {
						input = _ref2[_k];
						inputName = input.getAttribute("name");
						inputType = input.getAttribute("type");
						if (input.tagName === "SELECT" && input.hasAttribute("multiple")) {
							_ref3 = input.options;
							for (_l = 0, _len3 = _ref3.length; _l < _len3; _l++) {
								option = _ref3[_l];
								if (option.selected) {
									formData.append(inputName, option.value);
								}
							}
						} else if (!inputType || ((_ref4 = inputType.toLowerCase()) !== "checkbox" && _ref4 !== "radio") || input.checked) {
							formData.append(inputName, input.value);
						}
					}
				}
				for (i = _m = 0, _ref5 = files.length - 1; 0 <= _ref5 ? _m <= _ref5 : _m >= _ref5; i = 0 <= _ref5 ? ++_m : --_m) {
					formData.append(this._getParamName(i), files[i], files[i].name);
				}
				return xhr.send(formData);
			};
			// 上传

			Dropzone.prototype._finished = function(files, responseText, e) {
				var file, _i, _len;
				for (_i = 0, _len = files.length; _i < _len; _i++) {
					file = files[_i];
					file.status = Dropzone.SUCCESS;
					this.emit("success", file, responseText, e);
					this.emit("complete", file);
				}
				if (this.options.uploadMultiple) {
					this.emit("successmultiple", files, responseText, e);
					this.emit("completemultiple", files);
				}
				if (this.options.autoProcessQueue) {
					return this.processQueue();
				}
			};

			Dropzone.prototype._errorProcessing = function(files, message, xhr) {
				var file, _i, _len;
				for (_i = 0, _len = files.length; _i < _len; _i++) {
					file = files[_i];
					file.status = Dropzone.ERROR;
					this.emit("error", file, message, xhr);
					this.emit("complete", file);
				}
				if (this.options.uploadMultiple) {
					this.emit("errormultiple", files, message, xhr);
					this.emit("completemultiple", files);
				}
				if (this.options.autoProcessQueue) {
					return this.processQueue();
				}
			};

			return Dropzone;

		})(Em);
		// 


		Dropzone.options = {};

		Dropzone.optionsForElement = function(element) {
			if (element.getAttribute("id")) {
				return Dropzone.options[camelize(element.getAttribute("id"))];
			} else {
				return void 0;
			}
		};

		Dropzone.instances = [];

		Dropzone.forElement = function(element) {
			if (typeof element === "string") {
				element = document.querySelector(element);
			}
			if ((element != null ? element.dropzone : void 0) == null) {
				throw new Error("No Dropzone found for given element. This is probably because you're trying to access it before Dropzone had the time to initialize. Use the `init` option to setup any additional observers on your Dropzone.");
			}
			return element.dropzone;
		};

		Dropzone.autoDiscover = true;

		Dropzone.discover = function() {
			var checkElements, dropzone, dropzones, _i, _len, _results;
			if (document.querySelectorAll) {
				dropzones = document.querySelectorAll(".dropzone");
			} else {
				dropzones = [];
				checkElements = function(elements) {
					var el, _i, _len, _results;
					_results = [];
					for (_i = 0, _len = elements.length; _i < _len; _i++) {
						el = elements[_i];
						if (/(^| )dropzone($| )/.test(el.className)) {
							_results.push(dropzones.push(el));
						} else {
							_results.push(void 0);
						}
					}
					return _results;
				};
				checkElements(document.getElementsByTagName("div"));
				checkElements(document.getElementsByTagName("form"));
			}
			_results = [];
			for (_i = 0, _len = dropzones.length; _i < _len; _i++) {
				dropzone = dropzones[_i];
				if (Dropzone.optionsForElement(dropzone) !== false) {
					_results.push(new Dropzone(dropzone));
				} else {
					_results.push(void 0);
				}
			}
			return _results;
		};

		Dropzone.blacklistedBrowsers = [/opera.*Macintosh.*version\/12/i];

		// 检查浏览器是否支持拖拽
		Dropzone.isBrowserSupported = function() {
			var capableBrowser, regex, _i, _len, _ref;
			capableBrowser = true;
			if (window.File && window.FileReader && window.FileList && window.Blob && window.FormData && document.querySelector) {
				if (!("classList" in document.createElement("a"))) {
					capableBrowser = false;
				} else {
					_ref = Dropzone.blacklistedBrowsers;
					for (_i = 0, _len = _ref.length; _i < _len; _i++) {
						regex = _ref[_i];
						if (regex.test(navigator.userAgent)) {
							capableBrowser = false;
							continue;
						}
					}
				}
			} else {
				capableBrowser = false;
			}
			return capableBrowser;
		};
		// 检查浏览器是否支持拖拽 end

		without = function(list, rejectedItem) {
			var item, _i, _len, _results;
			_results = [];
			for (_i = 0, _len = list.length; _i < _len; _i++) {
				item = list[_i];
				if (item !== rejectedItem) {
					_results.push(item);
				}
			}
			return _results;
		};

		camelize = function(str) {
			return str.replace(/[\-_](\w)/g, function(match) {
				return match.charAt(1).toUpperCase();
			});
		};

		Dropzone.createElement = function(string) {
			var div;
			div = document.createElement("div");
			div.innerHTML = string;
			return div.childNodes[0];
		};

		// 元素中
		Dropzone.elementInside = function(element, container) {
			if (element === container) {
				return true;
			}
			while (element = element.parentNode) {
				if (element === container) {
					return true;
				}
			}
			return false;
		};

		// 检查是否有效的文件
		Dropzone.isValidFile = function(file, acceptedFiles) {
			return file.type.indexOf('image') !== -1;
			// var baseMimeType, mimeType, validType, _i, _len;
			// if (!acceptedFiles) {
			// 	return true;
			// }
			// acceptedFiles = acceptedFiles.split(",");
			// mimeType = file.type;
			// baseMimeType = mimeType.replace(/\/.*$/, "");
			// for (_i = 0, _len = acceptedFiles.length; _i < _len; _i++) {
			// 	validType = acceptedFiles[_i];
			// 	validType = validType.trim();
			// 	if (validType.charAt(0) === ".") {
			// 		if (file.name.toLowerCase().indexOf(validType.toLowerCase(), file.name.length - validType.length) !== -1) {
			// 			return true;
			// 		}
			// 	} else if (/\/\*$/.test(validType)) {
			// 		if (baseMimeType === validType.replace(/\/.*$/, "")) {
			// 			return true;
			// 		}
			// 	} else {
			// 		if (mimeType === validType) {
			// 			return true;
			// 		}
			// 	}
			// }
			// return false;
		};
		// 检查是否有效的文件 end

		if (typeof jQuery !== "undefined" && jQuery !== null) {
			jQuery.fn.dropzone = function(options) {
				return this.each(function() {
					return new Dropzone(this, options);
				});
			};
		}

		if (typeof module !== "undefined" && module !== null) {
			module.exports = Dropzone;
		} else {
			window.Dropzone = Dropzone;
		}

		Dropzone.ADDED = "added";

		Dropzone.QUEUED = "queued";

		Dropzone.ACCEPTED = Dropzone.QUEUED;

		Dropzone.UPLOADING = "uploading";

		Dropzone.PROCESSING = Dropzone.UPLOADING;

		Dropzone.CANCELED = "canceled";

		Dropzone.ERROR = "error";

		Dropzone.SUCCESS = "success";


		/*
		
		Bugfix for iOS 6 and 7
		Source: http://stackoverflow.com/questions/11929099/html5-canvas-drawimage-ratio-bug-ios
		based on the work of https://github.com/stomita/ios-imagefile-megapixel
		 */

		detectVerticalSquash = function(img) {
			var alpha, canvas, ctx, data, ey, ih, iw, py, ratio, sy;
			iw = img.naturalWidth;
			ih = img.naturalHeight;
			canvas = document.createElement("canvas");
			canvas.width = 1;
			canvas.height = ih;
			ctx = canvas.getContext("2d");
			ctx.drawImage(img, 0, 0);
			data = ctx.getImageData(0, 0, 1, ih).data;
			sy = 0;
			ey = ih;
			py = ih;
			while (py > sy) {
				alpha = data[(py - 1) * 4 + 3];
				if (alpha === 0) {
					ey = py;
				} else {
					sy = py;
				}
				py = (ey + sy) >> 1;
			}
			ratio = py / ih;
			if (ratio === 0) {
				return 1;
			} else {
				return ratio;
			}
		};

		drawImageIOSFix = function(ctx, img, sx, sy, sw, sh, dx, dy, dw, dh) {
			var vertSquashRatio;
			vertSquashRatio = detectVerticalSquash(img);
			return ctx.drawImage(img, sx, sy, sw, sh, dx, dy, dw, dh / vertSquashRatio);
		};


		/*
		 * contentloaded.js
		 *
		 * Author: Diego Perini (diego.perini at gmail.com)
		 * Summary: cross-browser wrapper for DOMContentLoaded
		 * Updated: 20101020
		 * License: MIT
		 * Version: 1.2
		 *
		 * URL:
		 * http://javascript.nwbox.com/ContentLoaded/
		 * http://javascript.nwbox.com/ContentLoaded/MIT-LICENSE
		 */

		contentLoaded = function(win, fn) {
			var add, doc, done, init, poll, pre, rem, root, top;
			done = false;
			top = true;
			doc = win.document;
			root = doc.documentElement;
			add = (doc.addEventListener ? "addEventListener" : "attachEvent");
			rem = (doc.addEventListener ? "removeEventListener" : "detachEvent");
			pre = (doc.addEventListener ? "" : "on");
			init = function(e) {
				if (e.type === "readystatechange" && doc.readyState !== "complete") {
					return;
				}
				(e.type === "load" ? win : doc)[rem](pre + e.type, init, false);
				if (!done && (done = true)) {
					return fn.call(win, e.type || e);
				}
			};
			poll = function() {
				var e;
				try {
					root.doScroll("left");
				} catch (_error) {
					e = _error;
					setTimeout(poll, 50);
					return;
				}
				return init("poll");
			};
			if (doc.readyState !== "complete") {
				if (doc.createEventObject && root.doScroll) {
					try {
						top = !win.frameElement;
					} catch (_error) {}
					if (top) {
						poll();
					}
				}
				doc[add](pre + "DOMContentLoaded", init, false);
				doc[add](pre + "readystatechange", init, false);
				return win[add](pre + "load", init, false);
			}
		};

		Dropzone._autoDiscoverFunction = function() {
			if (Dropzone.autoDiscover) {
				return Dropzone.discover();
			}
		};

		contentLoaded(window, Dropzone._autoDiscoverFunction);

	}).call(this);

});

	if (typeof exports == "object") {
		module.exports = require("dropzone");
	} else if (typeof define == "function" && define.amd) {
		define([], function(){ return require("dropzone"); });
	} else {
		this["Dropzone"] = require("dropzone");
	}
})()