/*
Uploadify v3.2.1
Copyright (c) 2012 Reactive Apps, Ronnie Garcia
Released under the MIT License <http://www.opensource.org/licenses/mit-license.php> 
*/

(function($) {

	// These methods can be called by adding them as the first argument in the uploadify plugin call
	var methods = {

		init : function(options, swfUploadOptions) {
			
			// Create a reference to the jQuery DOM object
			var $this = $(this);

			// Clone the original DOM object
			var $clone = $this.clone();
			var uploadify_form_data = {}, csrf_token, csrf_param;
			csrf_token = $('meta[name=csrf-token]').attr('content');
			csrf_param = $('meta[name=csrf-param]').attr('content');
			uploadify_form_data[csrf_param] = encodeURI(csrf_token);
			uploadify_form_data['_mp_session'] = cookieSK;
			uploadify_form_data['timestamp'] = Math.random();
			// Setup the default options
			var settings = $.extend({
				// Required Settings
				id       : $this.attr('id'), // The ID of the DOM object
				swf      : '/uploadify.swf',  // The path to the uploadify SWF file
				uploader : '/tps',  // The path to the server-side upload script
				
				// Options
				auto            : true,               // Automatically upload files when added to the queue
				buttonClass     : '',                 // A class name to add to the browse button DOM object
				buttonCursor    : 'hand',             // The cursor to use with the browse button
				buttonImage     : '/images/transparent.gif',               // (String or null) The path to an image to use for the Flash browse button if not using CSS to style the button
				buttonText      : '上传作品',     // The text to use for the browse button
				checkExisting   : false,              // The path to a server-side script that checks for existing files on the server
				debug           : false,              // Turn on swfUpload debugging mode
				fileObjName     : 'filedata',         // The name of the file object to use in your server-side script
				fileSizeLimit   : 0,                  // The maximum size of an uploadable file in KB (Accepts units B KB MB GB if string, 0 for no limit)
				fileTypeDesc    : 'Image Files',        // The description for file types in the browse dialog
				fileTypeExts    : '*.gif; *.jpg; *.png; *.jpeg, *.GIF; *.JPG; *.PNG; *.JPEG',              // Allowed extensions in the browse dialog (server-side validation should also be used)
				height          : 32,                 // The height of the browse button
				itemTemplate    : false,              // The template for the file item in the queue
				method          : 'post',             // The method to use when sending files to the server-side upload script
				multi           : true,               // Allow multiple file selection in the browse dialog
				formData        : uploadify_form_data,                 // An object with additional data to send to the server-side upload script with every file upload
				preventCaching  : true,               // Adds a random value to the Flash URL to prevent caching of it (conflicts with existing parameters)
				progressData    : 'percentage',       // ('percentage' or 'speed') Data to show in the queue item during a file upload
				queueID         : false,              // The ID of the DOM object to use as a file queue (without the #)
				queueSizeLimit  : 100,                 // The maximum number of files that can be in the queue at one time
				removeCompleted : true,               // Remove queue items from the queue when they are done uploading
				removeTimeout   : 1,                  // The delay in seconds before removing a queue item if removeCompleted is set to true
				requeueErrors   : false,              // Keep errored files in the queue and keep trying to upload them
				successTimeout  : 30,                 // The number of seconds to wait for Flash to detect the server's response after the file has finished uploading
				uploadLimit     : 0,                  // The maximum number of files you can upload
				width           : 105,                // The width of the browse button
				
				// Events
				overrideEvents  : []
			}, options);

			// Prepare settings for SWFUpload
			var swfUploadSettings = {
				assume_success_timeout   : settings.successTimeout,
				button_placeholder_id    : settings.id,
				button_width             : settings.width,
				button_height            : settings.height,
				button_text              : null,
				button_text_style        : null,
				button_text_top_padding  : 0,
				button_text_left_padding : 0,
				button_action            : (settings.multi ? SWFUpload.BUTTON_ACTION.SELECT_FILES : SWFUpload.BUTTON_ACTION.SELECT_FILE),
				button_disabled          : false,
				button_cursor            : (settings.buttonCursor == 'arrow' ? SWFUpload.CURSOR.ARROW : SWFUpload.CURSOR.HAND),
				button_window_mode       : SWFUpload.WINDOW_MODE.TRANSPARENT,
				debug                    : settings.debug,						
				requeue_on_error         : settings.requeueErrors,
				file_post_name           : settings.fileObjName,
				file_size_limit          : settings.fileSizeLimit,
				file_types               : settings.fileTypeExts,
				file_types_description   : settings.fileTypeDesc,
				file_queue_limit         : settings.queueSizeLimit,
				file_upload_limit        : settings.uploadLimit,
				flash_url                : settings.swf,					
				prevent_swf_caching      : settings.preventCaching,
				post_params              : settings.formData,
				upload_url               : settings.uploader,
				use_query_string         : (settings.method == 'get'),
				
				// Event Handlers 
				file_dialog_complete_handler : handlers.onDialogClose,
				file_dialog_start_handler    : handlers.onDialogOpen,
				file_queued_handler          : handlers.onSelect,
				file_queue_error_handler     : handlers.onSelectError,
				swfupload_loaded_handler     : settings.onSWFReady,
				upload_complete_handler      : handlers.onUploadComplete,
				upload_error_handler         : handlers.onUploadError,
				upload_progress_handler      : handlers.onUploadProgress,
				upload_start_handler         : handlers.onUploadStart,
				upload_success_handler       : handlers.onUploadSuccess
			}

			// Merge the user-defined options with the defaults
			if (swfUploadOptions) {
				swfUploadSettings = $.extend(swfUploadSettings, swfUploadOptions);
			}
			// Add the user-defined settings to the swfupload object
			swfUploadSettings = $.extend(swfUploadSettings, settings);
			
			// Detect if Flash is available
			var playerVersion  = swfobject.getFlashPlayerVersion();
			var flashInstalled = (playerVersion.major >= 9);

			if (flashInstalled) {
				// Create the swfUpload instance
				window['uploadify_' + settings.id] = new SWFUpload(swfUploadSettings);
				var swfuploadify = window['uploadify_' + settings.id];

				// Add the SWFUpload object to the elements data object
				$this.data('uploadify', swfuploadify);
				
				// Wrap the instance
				var $wrapper = $('<div />', {
					'id'    : settings.id,
					'class' : 'uploadify',
					'css'   : {
								'height'   : settings.height + 'px',
								'width'    : settings.width + 'px',
								'top'      : $(".button.browse_files.action").offset().top + 'px',
								'left'     : $(".button.browse_files.action").offset().left + 'px'
							  }
				});
				// 此处产生一个swf的请求
				$('#' + swfuploadify.movieName).wrap($wrapper);
				// Recreate the reference to wrapper
				$wrapper = $('#' + settings.id);
				// Add the data object to the wrapper 
				$wrapper.data('uploadify', swfuploadify);

				// Create the button
				var $button = $('<div />', {
					'id'    : settings.id + '-button',
					'class' : 'uploadify-button ' + settings.buttonClass
				});
				if (settings.buttonImage) {
					$button.css({
						'background-image' : "url('" + settings.buttonImage + "')",
						'text-indent'      : '-9999px'
					});
				}
				$button.html('<a href="javascript:void(0);">' + settings.buttonText + '</a>').css({
					'height'      : settings.height + 'px',
					'line-height' : settings.height + 'px',
					'width'       : settings.width + 'px'
				});
				// Append the button to the wrapper
				$wrapper.append($button);

				// Adjust the styles of the movie
				// 此处产生一个swf的请求
				$('#' + swfuploadify.movieName).css({
					'position' : 'absolute',
					'z-index'  : 1,
					'left'     : 0
				});
				
				// Create the file queue
				// if (!settings.queueID) {
				// 	var $queue = $(settings.id + '-queue');
				// 	swfuploadify.settings.queueID      = settings.id + '-queue';
				// 	swfuploadify.settings.defaultQueue = true;
				// }
				
				// Create some queue related objects and variables
				swfuploadify.queueData = {
					files              : {}, // The files in the queue
					filesSelected      : 0, // The number of files selected in the last select operation
					filesQueued        : 0, // The number of files added to the queue in the last select operation
					filesReplaced      : 0, // The number of files replaced in the last select operation
					filesCancelled     : 0, // The number of files that were cancelled instead of replaced
					filesErrored       : 0, // The number of files that caused error in the last select operation
					uploadsSuccessful  : 0, // The number of files that were successfully uploaded
					uploadsErrored     : 0, // The number of files that returned errors during upload
					averageSpeed       : 0, // The average speed of the uploads in KB
					queueLength        : 0, // The number of files in the queue
					queueSize          : 0, // The size in bytes of the entire queue
					uploadSize         : 0, // The size in bytes of the upload queue
					queueBytesUploaded : 0, // The size in bytes that have been uploaded for the current upload queue
					uploadQueue        : [], // The files currently to be uploaded
					errorMsg           : '文件不能添加到队列' // 'Some files were not added to the queue:'
				};

				// Save references to all the objects
				swfuploadify.original = $clone;
				swfuploadify.wrapper  = $wrapper;
				swfuploadify.button   = $button;
				// swfuploadify.queue    = $queue;

				// Call the user-defined init event handler
				// if (settings.onInit) settings.onInit.call($this, swfuploadify);

			} else {

				// Call the fallback function
				if (settings.onFallback) settings.onFallback.call($this);

			}

		},

		// 停止一个文件的上传和从队列中删除
		// 没有调用的机会
		cancel : function(fileID, supressEvent) {
		},
		// 恢复DOM对象恢复到原来的状态
		destroy : function() {
		},

		// Disable the select button
		disable : function(isDisabled) {
		},

		// Get or set the settings data
		settings : function(name, value, resetObjects) {
		},

		stop : function() {
		},

		// Start uploading files in the queue
		upload : function() {

			var args = arguments;

			// this.each(function() {
				// Create a reference to the jQuery DOM object
			var $this        = $(this),
				swfuploadify = $this.data('uploadify');

			// Reset the queue information
			swfuploadify.queueData.averageSpeed  = 0;
			swfuploadify.queueData.uploadSize    = 0;
			swfuploadify.queueData.bytesUploaded = 0;
			swfuploadify.queueData.uploadQueue   = [];
			
			// Upload the files
			if (args[0]) {
				if (args[0] == '*') {
					swfuploadify.queueData.uploadSize = swfuploadify.queueData.queueSize;
					swfuploadify.queueData.uploadQueue.push('*');
					swfuploadify.startUpload();
				} else {
					for (var n = 0; n < args.length; n++) {
						swfuploadify.queueData.uploadSize += swfuploadify.queueData.files[args[n]].size;
						swfuploadify.queueData.uploadQueue.push(args[n]);
					}
					swfuploadify.startUpload(swfuploadify.queueData.uploadQueue.shift());
				}
			} else {
				swfuploadify.startUpload();
			}
			// end 
		}

	}

	// These functions handle all the events that occur with the file uploader
	var handlers = {

		// Triggered when the file dialog is opened
		onDialogOpen : function() {
			// Load the swfupload settings
			var settings = this.settings;

			// Reset some queue info
			this.queueData.errorMsg       = '一些文件不能添加到队列:';
			this.queueData.filesReplaced  = 0;
			this.queueData.filesCancelled = 0;

			// Call the user-defined event handler
			// if (settings.onDialogOpen) settings.onDialogOpen.call(this);
		},

		
		// 当浏览对话框关闭触发
		onDialogClose :  function(filesSelected, filesQueued, queueLength) {
			// Load the swfupload settings
			var settings = this.settings;

			// Update the queue information
			this.queueData.filesErrored  = filesSelected - filesQueued;
			this.queueData.filesSelected = filesSelected;
			this.queueData.filesQueued   = filesQueued - this.queueData.filesCancelled;
			this.queueData.queueLength   = queueLength;

			if (this.queueData.filesErrored > 0) {
				alert(this.queueData.errorMsg);
			}

			// 添加处理
			if(this.queueData.filesQueued > 0){
				// 更新总量
				$(".drag-info").hide().parents(".uploader").addClass("loading")
				$(".wheels-bar .total-wheel").text(this.queueData.filesQueued);
				$(".wheels-bar .curr-wheel").text(1);
				// 移除上传文件的onmouse事件 添加继续上传的onmouse时间
				$(".button.submit").on("mouseover", Mpupload.flashMoveButton); // 或者放在onUploadComplete
				$(".button.browse_files.action").off("mouseover", Mpupload.flashMoveButton);
			};
			// 添加处理 end

			// Upload the files if auto is true
			if (settings.auto) $('#' + settings.id).uploadify('upload', '*');
		},

		// Triggered once for each file added to the queue
		onSelect : function(file) {
			// Load the swfupload settings
			var settings = this.settings;

			// 检查同名的文件是否已经在队列
			var queuedFile = {};
			for (var n in this.queueData.files) {
				queuedFile = this.queueData.files[n];
				if (queuedFile.uploaded != true && queuedFile.name == file.name) {
					var replaceQueueItem = confirm('作品 "' + file.name + '" 已在上传队列,您要替换嘛？');
					if (!replaceQueueItem) {
						this.cancelUpload(file.id);
						this.queueData.filesCancelled++;
						return false;
					} else {
						$('#' + queuedFile.id).remove();
						this.cancelUpload(queuedFile.id);
						this.queueData.filesReplaced++;
					}
				}
			}
			this.queueData.queueSize += file.size;
			this.queueData.files[file.id] = file;
		},

		// Triggered when a file is not added to the queue
		onSelectError : function(file, errorCode, errorMsg) {
			// Load the swfupload settings
			var settings = this.settings;

			// Run the default event handler
			if ($.inArray('onSelectError', settings.overrideEvents) < 0) {
				switch(errorCode) {
					case SWFUpload.QUEUE_ERROR.QUEUE_LIMIT_EXCEEDED:
						if (settings.queueSizeLimit > errorMsg) {
							// 一次允许settings.limit张，但您选择settings.limit + errorMsg张
							this.queueData.errorMsg += '\nThe number of files selected exceeds the remaining upload limit (' + errorMsg + ').';
						} else {
							this.queueData.errorMsg += '\n一次最多上传' + settings.queueSizeLimit + '张.';
						}
						break;
					case SWFUpload.QUEUE_ERROR.FILE_EXCEEDS_SIZE_LIMIT:
						this.queueData.errorMsg += '\nThe file "' + file.name + '" exceeds the size limit (' + settings.fileSizeLimit + ').';
						break;
					case SWFUpload.QUEUE_ERROR.ZERO_BYTE_FILE:
						this.queueData.errorMsg += '\nThe file "' + file.name + '" is empty.';
						break;
					case SWFUpload.QUEUE_ERROR.INVALID_FILETYPE:
						this.queueData.errorMsg += '\nThe file "' + file.name + '" is not an accepted file type (' + settings.fileTypeDesc + ').';
						break;
				}
			}
			if (errorCode != SWFUpload.QUEUE_ERROR.QUEUE_LIMIT_EXCEEDED) {
				delete this.queueData.files[file.id];
			}
		},

		// Triggered when all the files in the queue have been processed
		onQueueComplete : function() {
			// 全部文件上传完成 // 队列已经上传完 这个跟上传成功不成功似乎没关系
			$(".uploader").removeClass("loading").find(".wheels-bar .total-wheel").text(0);
			if(Mpupload.totalLength < 1){
				$(".drag-info").show();
			} else {
				// 如果没提示过裁剪
				if(!Mpupload.tipCutInfo){
					Mpupload.tipCutInfo = true;
					$(".uploader .crop-tooltip").css('opacity', '1').fadeIn('fast');
					setTimeout(function(){
						$(".uploader .crop-tooltip").css('opacity', '1').fadeOut('fast');
					}, 3000);
				}
			}
		},

		// Triggered when a file upload successfully completes
		onUploadComplete : function(file) {
			// Load the swfupload settings
			var settings     = this.settings,
				swfuploadify = this;

			var queueIsComplete = false;
			// 更新队列信息
			var stats = this.getStats();
			this.queueData.queueLength = stats.files_queued;
			if (this.queueData.uploadQueue[0] == '*') {
				if (this.queueData.queueLength > 0) {
					this.startUpload();
				} else {
					this.queueData.uploadQueue = [];
					queueIsComplete = true;
				}
			} else {
				if (this.queueData.uploadQueue.length > 0) {
					this.startUpload(this.queueData.uploadQueue.shift());
				} else {
					this.queueData.uploadQueue = [];
					queueIsComplete = true;
				}
			}

			swfuploadify.queueData.queueSize   -= file.size;
			swfuploadify.queueData.queueLength -= 1;
			delete swfuploadify.queueData.files[file.id];
			$(".loading-progress .area.green").css("width", '0%');
			$(".loading-progress .percentage .value").text(0);
			$(".wheels-bar .curr-wheel").text(this.queueData.filesQueued - this.queueData.queueLength);
			// 如果上传完成就插入图片到页面
			if(SWFUpload.FILE_STATUS.COMPLETE == file.filestatus){
				var data = this.respData;
				Mpupload.totalLength += 1;
				Mpupload.initQueue(data); // 初始化队列
				Mpupload.initDetails(data.id); // 初始化details
				
				Mpupload.initMap(data.id, data.exif.gps_latitude, data.exif.gps_longitude); // 初始化地图
				$(Mpupload.largeContainer).append(Mpupload.largeTemplate.replace("{{id}}", data.id).replace("{{src}}", data.large));
				$(Mpupload.thumbContainer).append(Mpupload.thumbTemplate.replace("{{id}}", data.id).replace("{{src}}", data.thumb));
				Mpupload.initCrop(data.id); // 初始化crop
				$(".remaining-photos p").text("还可以再上传" + (20 - Mpupload.totalLength) + "张作品");
				$(".photo-reel-photo[data-pid=" + data.id + "]").click();
				if(Mpupload.totalLength > 12){
					$(".photo-reel").addClass("scrollable");
				}
			}
			if(queueIsComplete){
				handlers.onQueueComplete(); // add from zhu
			}
		},

		// Triggered when a file upload returns an error
		onUploadError : function(file, errorCode, errorMsg) {
			// Load the swfupload settings
			var settings = this.settings;

			// Set the error string
			var errorString = 'Error';
			switch(errorCode) {
				case SWFUpload.UPLOAD_ERROR.HTTP_ERROR:
					errorString = 'HTTP Error (' + errorMsg + ')';
					break;
				case SWFUpload.UPLOAD_ERROR.MISSING_UPLOAD_URL:
					errorString = 'Missing Upload URL';
					break;
				case SWFUpload.UPLOAD_ERROR.IO_ERROR:
					errorString = 'IO Error';
					break;
				case SWFUpload.UPLOAD_ERROR.SECURITY_ERROR:
					errorString = 'Security Error';
					break;
				case SWFUpload.UPLOAD_ERROR.UPLOAD_LIMIT_EXCEEDED:
					alert('The upload limit has been reached (' + errorMsg + ').');
					errorString = 'Exceeds Upload Limit';
					break;
				case SWFUpload.UPLOAD_ERROR.UPLOAD_FAILED:
					errorString = 'Failed';
					break;
				case SWFUpload.UPLOAD_ERROR.SPECIFIED_FILE_ID_NOT_FOUND:
					break;
				case SWFUpload.UPLOAD_ERROR.FILE_VALIDATION_FAILED:
					errorString = 'Validation Error';
					break;
				case SWFUpload.UPLOAD_ERROR.FILE_CANCELLED:
					errorString = 'Cancelled';
					this.queueData.queueSize   -= file.size;
					this.queueData.queueLength -= 1;
					if (file.status == SWFUpload.FILE_STATUS.IN_PROGRESS || $.inArray(file.id, this.queueData.uploadQueue) >= 0) {
						this.queueData.uploadSize -= file.size;
					}
					// Trigger the onCancel event
					if (settings.onCancel) settings.onCancel.call(this, file);
					delete this.queueData.files[file.id];
					break;
				case SWFUpload.UPLOAD_ERROR.UPLOAD_STOPPED:
					errorString = 'Stopped';
					break;
			}
			var stats = this.getStats();
			this.queueData.uploadsErrored = stats.upload_errors;
		},

		// Triggered periodically during a file upload
		// 更新上传进度
		onUploadProgress : function(file, fileBytesLoaded, fileTotalBytes) {
			// Load the swfupload settings
			var settings = this.settings;

			// Setup all the variables
			var timer            = new Date();
			var newTime          = timer.getTime();
			var lapsedTime       = newTime - this.timer;
			if (lapsedTime > 500) {
				this.timer = newTime;
			}
			var lapsedBytes      = fileBytesLoaded - this.bytesLoaded;
			this.bytesLoaded     = fileBytesLoaded;
			var queueBytesLoaded = this.queueData.queueBytesUploaded + fileBytesLoaded;
			var percentage       = Math.round(fileBytesLoaded / fileTotalBytes * 100);

			$(".loading-progress .area.green").css("width", percentage + '%');
			$(".loading-progress .percentage .value").text(percentage);
		},

		onUploadStart : function(file) {
			$(".wheel-bar-filename").text(file.name);
		},

		// Triggered when a file upload returns a successful code
		onUploadSuccess : function(file, data, response) {
			// Load the swfupload settings
			var settings = this.settings;
			var stats    = this.getStats();
			this.queueData.uploadsSuccessful = stats.successful_uploads;
			this.queueData.queueBytesUploaded += file.size;
			// 如果异常就不进入这里了
			this.respData = JSON.parse(data);
		}

	}

	$.fn.uploadify = function(method) {

		if (methods[method]) {
			return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
		} else if (typeof method === 'object' || !method) {
			return methods.init.apply(this, arguments);
		} else {
			$.error('The method ' + method + ' does not exist in $.uploadify');
		}

	}

})($);