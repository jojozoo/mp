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
    $field = $("#image_picture");
    $field.uploadify({//配置uploadify
        'formData'  : {
                        'timestamp' : Math.random(),
                        'token'     : Math.random()
                    },
        'scriptData': {
                        "<%= key = Rails.application.config.session_options[:key] %>" :"<%= cookies[key] %>",
                        "<%= request_forgery_protection_token %>" : "<%= form_authenticity_token %>"
        },
        // xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
        'buttonText': '选择图片',  //选择按钮显示的字符
        'swf'       : '/uploadify/uploadify.swf', //swf文件的位置
        'uploader'  : $field.parents("form").attr("action"), //上传的接收者
        'cancelImg' : '/uploadify/uploadify-cancel.png',
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
            console.log(file.name);
            // $wrap.find("p.picInfo span").text(file.name);//file.name为选中的图片名称
        },
     
        'onUploadSuccess' : function(file, data, response) {  //上传成功后的触发事件
            $field.uploadify('disable', true);  //(上传成功后)'disable'禁止再选择图片
            data = JSON.parse(data);  //data为接收方(receivePic.php)返回的数据，稍后描述
     
    //此时开始对取回的数据处理出需要的图片名，宽高，并计算出原图比例尺，开始设定裁剪需要的计算量
     
            var orignW = data.width,//存储原图的宽高，用于计算
                orignH = data.height,
                aspectRatio = JSON.parse(picFormat)[index].width/JSON.parse(picFormat)[index].height,//提前设定的裁剪宽高比，规定随后裁剪的宽高比例
                frameW = 260,  //原图的缩略图固定宽度，作为一个画布，限定宽度，高度自适应，保证了原图比例
                frameH = 0,
                prevFrameW = 140,  //预览图容器的高宽，宽度固定，高为需要裁剪的宽高比决定
                prevFrameH = 140/aspectRatio,
                rangeX   = 1,  //初始缩放比例
                rangeY   = 1,
                prevImgW = prevFrameW,  //初始裁剪预览图宽高
                prevImgH = prevFrameW;
     
            $imgTar = $wrap.find("img.pic"),  //画布
            $imgCut = $cut.find("img.cutImg");//预览图
     
            $imgTar.attr("src","/Picture/"+data.filename);//显示已上传的图片，此时图片已在服务器上
            frameH = Math.round(frameW*orignH/orignW);//根据原图宽高比和画布固定宽计算画布高，即$imgTar加载上传图后的高。此处不能简单用.height()获取，有DOM加载的延迟
            $cut.find(".preview").css('height',Math.round(prevFrameH)+"px");//设置裁剪后的预览图的容器高，注意此时的高度应由裁剪宽高比决定，而非原图宽高比
     
    //准备存放图片数据的变量，便于传回裁剪坐标
            CutJson.name = data.filename;
            CutJson.position = {};
     
    //准备好数据后，开始配置imgAreaSelect使得图片可选区
            var imgArea = $imgTar.imgAreaSelect({ //配置imgAreaSelect
                instance: true,  //配置为一个实例，使得绑定的imgAreaSelect对象可通过imgArea来设置
                handles: true,   //选区样式，四边上8个方框,设为corners 4个
                fadeSpeed: 300, //选区阴影建立和消失的渐变
                aspectRatio:'1:'+(1/aspectRatio), //比例尺
     
                onSelectChange: function(img,selection){//选区改变时的触发事件
                /*selection包括x1,y1,x2,y2,width,height几个量，分别为选区的偏移和高宽。*/
                    rangeX   = selection.width/frameW;  //依据选取高宽和画布高宽换算出缩放比例
                    rangeY   = selection.height/frameH;
                    prevImgW = prevFrameW/rangeX; //根据缩放比例和预览图容器高宽得出预览图的高宽
                    prevImgH = prevFrameH/rangeY;
     
    //实时调整预览图预览裁剪后效果，可参见http://odyniec.net/projects/imgareaselect/ 的Live Example
                    $imgCut.css({
                        'width' : Math.round(prevImgW)+"px",
                        'height' : Math.round(prevImgH)+"px",
                        'margin-left':"-"+Math.round((prevFrameW/selection.width)*selection.x1)+"px",
                        'margin-top' :"-"+Math.round((prevFrameH/selection.height)*selection.y1)+"px"
                     
                    });
                },
                onSelectEnd: function(img,selection){//放开选区后的触发事件
                    //计算实际对于原图的裁剪坐标
                    CutJson.position.x1 = Math.round(orignW*selection.x1/frameW);
                    CutJson.position.y1 = Math.round(orignH*selection.y1/frameH);
                    CutJson.position.width  = Math.round(rangeX*orignW);
                    CutJson.position.height = Math.round(rangeY*orignH);
                }
            });
        }
    });


})
