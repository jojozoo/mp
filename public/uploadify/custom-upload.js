// {
// "authenticity_token"=>"bVh/GreVlsqVXFIePg7vnJaJt0qOOrbfI9ltFnAb2VM=", 
// "image_avatar"=>{
//     "picture"=>#<ActionDispatch::Http::UploadedFile:0x007f9310b131b8 @original_filename="00006.jpg", @content_type="image/jpeg", @headers="Content-Disposition: form-data; name=\"image_avatar[picture]\"; filename=\"00006.jpg\"\r\nContent-Type: image/jpeg\r\n", @tempfile=#<Tempfile:/var/folders/q5/y7_5x_9d46z5zx07scq3q5xr0000gn/T/RackMultipart20140114-2044-1j9kr5g>>
// }, 
// "commit"=>"上传头像", 
// "type"=>"avatar"
// }
// @content_type="application/octet-stream" 这个不同
//  {
//     "Filename"=>"00006.jpg", 
//     "timestamp"=>"0.5653842778410763", 
//     "token"=>"0.34840902872383595", 
//     "Filedata"=>#<ActionDispatch::Http::UploadedFile:0x007f9310823340 @original_filename="00006.jpg", @content_type="application/octet-stream", @headers="Content-Disposition: form-data; name=\"Filedata\"; filename=\"00006.jpg\"\r\nContent-Type: application/octet-stream\r\n", @tempfile=#<Tempfile:/var/folders/q5/y7_5x_9d46z5zx07scq3q5xr0000gn/T/RackMultipart20140114-2044-ubymub>>,
//     "Upload"=>"Submit Query", 
//     "type"=>"avatar"
// }
$(function(){
    $field = $("#upload-file");
    $field.uploadify({//配置uploadify
        'formData'  : {
                        'timestamp' : Math.random(),
                        '<%= key = Rails.application.config.session_options[:key] %>' :'<%= cookies[key] %>',
                        '<%= request_forgery_protection_token %>' : '<%= form_authenticity_token %>'
                    },
        // xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
        'buttonText': '选择图片',  //选择按钮显示的字符
        'preventCaching' : true,
        'swf'       : '/uploadify/uploadify.swf', //swf文件的位置
        'uploader'  : '/images/avatar', //上传的接收者
        'cancelImg' : 'uploadify-cancel.png',
        'folder'    : '/upload',//上传图片的存放地址
        'auto'      : false,    //选择图片后是否自动上传
        'multi'     : false,   //是否允许同时选择多个(false一次只允许选中一张图片)
        'method'    : 'post',
        'debug'     : true,
        'queueSizeLimit' : 1,//最多能选择加入的文件数量
        'fileTypeExts': '*.gif; *.jpg; *.png; *.jpeg', //允许的后缀
        'fileTypeDesc': 'Image Files', //允许的格式，详见文档
     
        'onSelect': function(file) {//选择文件后的触发事件
            $(".gogo").show().click(function(){//自定义的按钮，显示点击执行上传
                $field.uploadify('upload','*');//此处触发上传
                return false;
            });
        },
     
        'onUploadSuccess' : function(file, data, response) {  //上传成功后的触发事件
            $field.uploadify('disable', true);  //(上传成功后)'disable'禁止再选择图片
            var data = JSON.parse(data),
                max_value = (data.width > data.height) ? data.width : data.height,
                min_value = (data.width > data.height) ? data.height : data.width,
                radio     = max_value > 300 ? (300 / max_value) : 1,
                suo_value = parseInt(min_value * radio);


                // orignH    = (data.width > data.height ? data.height : data.width) / min_value;
                // orignW    = 
                // radio     = , // 300框的压缩比
                // x2y2      = parseInt(min_value * (max_value > 300 ? (300 / max_value) : 1)), // x2y2坐标值

            var imageArea = $('#cut-area');
            // 显示已上传的图片
            imageArea.attr('src', data.original);
            // 裁剪结果替换
            $(".review img").attr("src", data.original);
            ///////////////////配置选择结果///////////////

            ///////////////////////////////////////////
            //准备好数据后，开始配置imgAreaSelect使得图片可选区
            //配置imgAreaSelect
            var imgArea = imageArea.imgAreaSelect({
                aspectRatio: '1:1',
                instance: true,  //配置为一个实例，使得绑定的imgAreaSelect对象可通过imgArea来设置
                handles: true,   //选区样式，四边上8个方框,设为corners 4个
                x1: 0,
                y1: 0,
                x2: suo_value,
                y2: suo_value,
     
                onSelectChange: function(img,selection){
                    $('.s200').css({
                        width: Math.round(data.width * radio * 200 / Math.abs(selection.x2 - selection.x1)) + 'px',
                        height: Math.round(data.height * radio * 200 / Math.abs(selection.y2 - selection.y1)) + 'px',
                        'margin-left': '-' + Math.round(selection.x1 * 200 / Math.abs(selection.x2 - selection.x1)) + 'px',
                        'margin-top': '-' + Math.round(selection.y1 * 200 / Math.abs(selection.x2 - selection.x1)) + 'px'
                    });
                },
                onSelectEnd: function(img,selection){//放开选区后的触发事件
                    // //计算实际对于原图的裁剪坐标
                    // CutJson.position.x1 = Math.round(orignW*selection.x1/frameW);
                    // CutJson.position.y1 = Math.round(orignH*selection.y1/frameH);
                    // CutJson.position.width  = Math.round(rangeX*orignW);
                    // CutJson.position.height = Math.round(rangeY*orignH);
                }
            });
        }
    });
})
