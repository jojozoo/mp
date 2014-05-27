$(function(){
    var $field = $("#upload-menu");
    // 判断是否需要初始化upload start
    if($field.length > 0){
        // form_data
        var uploadify_form_data = {}, csrf_token, csrf_param;
        csrf_token = $('meta[name=csrf-token]').attr('content');
        csrf_param = $('meta[name=csrf-param]').attr('content');
        uploadify_form_data[csrf_param] = encodeURI(csrf_token);
        uploadify_form_data['timestamp'] = Math.random();
        // 配置uploadify
        $field.uploadify({
            'formData'        : uploadify_form_data,
            'buttonText'      : '上传照片',                              //选择按钮显示的字符
            'preventCaching'  : true,
            'height'          : 32,
            'width'           : 105,
            'swf'             : '/uploadie/uploadify.swf',              //swf文件的位置
            'uploader'        : '/photos/upload',                       //上传的接收者
            // 'cancelImg'       : 'uploadify-cancel.png',
            'folder'          : '/upload',                              //上传图片的存放地址
            'auto'            : true,                                   //选择图片后是否自动上传
            'multi'           : true,                                   //是否允许同时选择多个(false一次只允许选中一张图片)
            'method'          : 'post',
            'queueSizeLimit'  : 20,                                     //最多能选择加入的文件数量
            'fileTypeExts'    : '*.gif; *.jpg; *.png; *.jpeg',          //允许的后缀
            'fileTypeDesc'    : 'Image Files',                          //允许的格式，详见文档
            'itemTemplate'    : '',
            onDialogClose     : function(queueData){
                var sum = queueData.queueLength;
                if(sum > 0){
                    // 更新总量 TODO [2014-05-28 00:35:24] ERROR invalid body size.
                    $(".uploader").addClass("loading").find(".wheels-bar .total-wheel").text(sum);
                    document.getElementById("upload-menu").style.width = 80;
                    document.getElementById("upload-menu-button").style.width = 80;
                    document.getElementById("SWFUpload_0").width = 80;

                    $("#upload-menu-button a").attr("class", "button submit").text("继续上传");
                    // 把按钮挪到继续上传上去
                    var uploadMenu = document.getElementById('upload-menu');
                    // uploadMenu.remove();
                    // $(".button.submit").replaceWith(uploadMenu);
                }
            },
            onUploadStart     : function(){
                console.log('start');
            },
            onUploadComplete  : function(){
                console.log('onUploadComplete');
            },
            onUploadSuccess   : function(file, data, response) {        //上传成功后的触发事件
                console.log('success');
            }
        });
    }; // 判断是否需要初始化upload end
});
