

$(function() {

    // href data-url 登录后的跳转地址 data-init
    var POPBox = {
        isIE6: false,
        hostname: window.location.host,
        isInitSignIn: true,
        isChecked: true,
        emailRegexp: /^(?:\w+\.?)*\w+@(?:\w+\.)+\w+$/,
        phonePhoneRegexp: /^(([0\+]\d{2,3}-)?(0\d{2,3})-)?(\d{7,8})(-(\d{3,}))?$/,
        usernameRegexp: /[\w\u4e00-\u9fa5]{2,10}/,
        passwordRegexp: /^\s*[\@A-Za-z0-9\!\#\$\%\^\&\*\.\~]{6,16}\s*$/,
        redirectUrl: window.location.href
    };
    //创建登录框
    POPBox.mppopupBox = function(settings) {
        var box;
        //已经存在
        if ($('.mppopup-box').length != 0) {
            POPBox.mppopupBoxShow();
        } else {
            box = '<div class="mppopup-box" id="mppopup-box">' +
                        '<div class="mppopup-box-left mppopup-box-item">' +
                            '<form method="post" action="/sign_in" class="mp-sign-form mp-sign-form-sign_in" style="display: '+ (POPBox.isInitSignIn ? 'block' : 'none') +'">' +
                                '<h3>立即登录</h3>' +
                                '<div class="mp-sign-form-div">' +
                                    '<span class="sign-placeholder">输入帐号/邮箱/手机</span>' +
                                    '<input type="text" place-holder="正确帐号邮箱或手机" name="user[username]" class="mp-sign-blur form-control" tabindex="100" />' +
                                '</div>' +
                                '<div class="mp-sign-form-div">' +
                                    '<span class="sign-placeholder">输入登录密码</span>' +
                                    '<input type="password" place-holder="密码" name="user[password]" class="mp-sign-blur form-control" maxlength="16" tabindex="101" />' +
                                '</div>' +
                                '<div class="mp-sign-form-div">' +
                                    '<input name="authenticity_token" type="hidden" value="'+ $('meta[name=csrf-token]').attr('content') +'">' +
                                    '<input type="hidden" name="remember" value="on" />' +
                                    '<input type="hidden" name="redirect" value="' + POPBox.redirectUrl + '" />' +
                                    '<label class="pboxtb checked">保持登录状态</label>' +
                                    '<a href="/forgot" class="get-back-password" target="_blank" title="找回密码">找回密码</a>' +
                                '</div>' +
                                '<div class="mp-sign-form-div">' +
                                    '<input type="button" id="sign-form-submit-sign_in-btn" class="pboxtb sing-form-submit-btn" value="" tabindex="102" />' +
                                    '<a href="javascript:void(0);" class="left40_blue fblue sign-up_now" target="_blank">没有帐号，立即注册</a>' +
                                '</div>' +
                            '</form>' +
                            '<form method="post" action="/sign_up" class="mp-sign-form mp-sign-form-sign_up" style="display: '+ (POPBox.isInitSignIn ? 'none' : 'block') +'">' +
                                '<h3>快速注册漫拍网</h3>' +
                                '<input name="authenticity_token" type="hidden" value="'+ $('meta[name=csrf-token]').attr('content') +'">' + 
                                '<div class="mp-sign-form-div">' +
                                    '<span class="sign-placeholder">帐号</span>' +
                                    '<input type="text" place-holder="帐号" name="user[username]" class="mp-sign-blur form-control" tabindex="200" />' +
                                '</div>' +
                                '<div class="mp-sign-form-div">' +
                                    '<span class="sign-placeholder">邮箱</span>' +
                                    '<input type="text" place-holder="邮箱" name="user[email]" class="mp-sign-blur form-control" tabindex="201" />' +
                                '</div>' +
                                '<div class="mp-sign-form-div">' +
                                    '<span class="sign-placeholder">密码</span>' +
                                    '<input type="password" place-holder="密码" name="user[password]" class="mp-sign-blur form-control" maxlength="16" tabindex="202" />' +
                                '</div>' +
                                '<div class="mp-sign-form-div">' +
                                    '<input type="button" id="sign-form-submit-sign_up-btn" class="pboxtb sing-form-submit-btn" value="" tabindex="203" />' +
                                    '<a href="javascript:void(0);" class="left40_blue fblue sign-in_now" target="_blank">已有帐号，直接登录</a>' +
                                '</div>' +
                                '<input type="hidden" name="redirect" />' +
                            '</form>' +
                        '</div>' +
                        '<div class="mppopup-box-right mppopup-box-item">' +
                            '<div class="socials">' +
                                '<p>使用社交帐号登录</p>' +
                                '<a href="/oauth/qzone" class="boxsocials-qzone" title="用QQ帐号登录">用QQ帐号登录</a>' +
                                '<a href="/oauth/weibo" class="boxsocials-weibo" title="用新浪微博登录">用新浪微博登录</a>' +
                                '<a href="/oauth/renren" class="boxsocials-renren" title="用人人帐号登录">用人人帐号登录</a>' +
                                '<a href="/oauth/douban" class="boxsocials-douban" title="用豆瓣帐号登录">用豆瓣帐号登录</a>' +
                            '</div>' +
                        '</div>' +
                        '<b class="pboxtb close" title="关闭"></b>' +
                    '</div>' +
                    '<div class="mppopup-box-outerboder" id="mppopup-box-outer-shade"></div>' +
                    '<div class="mppopup-box-background" id="mppopup-box-shade">' +
                        '<iframe src="about:blank" border="0" frameborder="0" scrolling="no" style="width:100%;height:' + $(document).height() + 'px;background:transparent;"></iframe>' +
                    '</div>'

            
            $('body').append(box);
            if (POPBox.isIE6) {
                $('.mppopup-box,.mppopup-box-outerboder').css({
                    top: document.documentElement.scrollTop + 150
                });
                $(window).scroll(function() {
                    $('.mppopup-box,.mppopup-box-outerboder').css('top', document.documentElement.scrollTop + 150);
                });
            }
        }
    };
    // 隐藏登录框
    POPBox.mppopupBoxRemove = function(){
        $('.mppopup-box,.mppopup-box-background,.mppopup-box-outerboder').remove();
    }
    // 显示登录框
    POPBox.mppopupBoxShow = function() {
        $('.mppopup-box,.mppopup-box-background,.mppopup-box-outerboder').show();
    };

    // 登录 username
    $(document).on('blur', '.mp-sign-form-sign_in input[name="user[username]"]', function(){
        var _val = $.trim($(this).val());
        var _tip = $(this).attr('place-holder');
        $(this).removeClass('mp-sign-error').nextAll('div.help-block-error').remove();
        if(_val === '' || (!POPBox.emailRegexp.test(_val) && !POPBox.phonePhoneRegexp.test(_val) && !POPBox.usernameRegexp.test(_val))){
            $(this).addClass('mp-sign-error').after('<div class="help-block-error">' + _tip + '</div>');
        }
    });
    // 登录 password
    $(document).on('blur', '.mp-sign-form-sign_in input[name="user[password]"]', function(){
        var _val = $.trim($(this).val());
        $(this).removeClass('mp-sign-error').nextAll('div.help-block-error').remove();
        if(_val === ''){
            $(this).prev('span.sign-placeholder').show();
            $(this).addClass('mp-sign-error').after('<div class="help-block-error">请输入密码</div>');
        }
        if(_val !== '' && !POPBox.passwordRegexp.test(_val)) {
            $(this).addClass('mp-sign-error').after('<div class="help-block-error">密码长度应该在6-16位之间</div>');
        }
    });
    // 注册 username
    $(document).on('blur', '.mp-sign-form-sign_up input[name="user[username]"]', function(){
        var _val = $.trim($(this).val());
        var _tip = $(this).attr('place-holder');
        $(this).removeClass('mp-sign-error').nextAll('div.help-block-error').remove();
        if(_val === ''){
            $(this).addClass('mp-sign-error').after('<div class="help-block-error">请输入' + _tip + '</div>');
        } else {
            if(!POPBox.usernameRegexp.test(_val)){
                $(this).addClass('mp-sign-error').after('<div class="help-block-error">2-10位汉字/字母/数字/_组成</div>');
            }
        }
    });
    // 注册 email
    $(document).on('blur', '.mp-sign-form-sign_up input[name="user[email]"]', function(){
        var _val = $.trim($(this).val());
        var _tip = $(this).attr('place-holder');
        $(this).removeClass('mp-sign-error').nextAll('div.help-block-error').remove();
        if(_val === ''){
            $(this).addClass('mp-sign-error').after('<div class="help-block-error">请输入' + _tip + '</div>');
        } else {
            if(!POPBox.emailRegexp.test(_val)){
                $(this).addClass('mp-sign-error').after('<div class="help-block-error">邮箱格式不正确</div>');
            }
        }
    });
    // 注册 password
    $(document).on('blur', '.mp-sign-form-sign_up input[name="user[password]"]', function(){
        var _val = $.trim($(this).val());
        var _tip = $(this).attr('place-holder');
        $(this).removeClass('mp-sign-error').nextAll('div.help-block-error').remove();
        if(_val === ''){
            $(this).prev('span.sign-placeholder').show();
            $(this).addClass('mp-sign-error').after('<div class="help-block-error">请设置6-16位英文字母，数字，符号密码</div>');
        }
        if(_val !== '' && !POPBox.passwordRegexp.test(_val)) {
            $(this).addClass('mp-sign-error').after('<div class="help-block-error">请设置6-16位英文字母，数字，符号密码</div>');
        }
    });

    // // 手机、邮箱
    // $(document).on('blur', '.mp-sign-form input.mp-sign-blur', function() {
    //     var _val, _type, _tip, _item, _isSignIn;
    //     _val  = $.trim($(this).val());
    //     _tip  = $(this).attr('place-holder');
    //     _type = $(this).attr('type');
    //     _item = $(this).attr('name');
    //     _isSignIn = $(this).parents('form').hasClass('mp-sign-form-sign_in');

    //     $(this).nextAll('div.help-block-error').remove();
    //     $(this).removeClass('mp-sign-error');
    //     // nextAll
    //     if(_val === ''){
    //         $(this).prev('span.sign-placeholder').show();
    //     }
    //     if(_type === 'password'){
    //         if(_val === ''){
    //             if(_isSignIn){
    //                 $(this).after('<div class="help-block-error">请输入密码</div>');
    //             } else {
    //                 $(this).after('<div class="help-block-error">请设置6-16位英文字母，数字，符号密码</div>');
    //             }
    //         } else {
    //             if(!POPBox.passwordRegexp.test(_val)){
    //                 if(_isSignIn){
    //                     $(this).after('<div class="help-block-error">密码长度应该在6-16位之间</div>');
    //                 } else {
    //                     $(this).after('<div class="help-block-error">请设置6-16位英文字母，数字，符号密码</div>');
    //                 }
    //             }
    //         }
    //     } else {
    //         // 如果是其他
    //         if(_isSignIn){
    //             if(_val === '' || (!POPBox.emailRegexp.test(_val) && !POPBox.phonePhoneRegexp.test(_val) && !POPBox.usernameRegexp.test(_val))){
    //                 $(this).addClass('mp-sign-error');
    //                 $(this).after('<div class="help-block-error">' + _tip + '</div>');
    //             }
    //         } else {
    //             // 如果是注册并且是用户
    //             if(_item === 'user[username]') {
    //                 if(_val === ''){
    //                     $(this).after('<div class="help-block-error">请输入' + _tip + '</div>');
    //                 } else {
    //                     if(!POPBox.usernameRegexp.test(_val)){
    //                         $(this).after('<div class="help-block-error">2-10位汉字/字母/数字/_组成</div>');
    //                     }
    //                 }
    //             }
    //             // 如果是注册并且是邮箱
    //             if(_item === 'user[email]'){
    //                 if(_val === ''){
    //                     $(this).after('<div class="help-block-error">请输入' + _tip + '</div>');
    //                 } else {
    //                     if(!POPBox.emailRegexp.test(_val)){
    //                         $(this).after('<div class="help-block-error">邮箱格式不正确</div>');
    //                     }
    //                 }
    //             }
    //         }
    //     }
    // });

    // 保持登录状态 Checkbox
    $(document).on('click', '.mp-sign-form label', function() {
        $(this).toggleClass('checked');
        if ($(this).hasClass('checked')) {
            $(this).parent().find('[name="remember"]').val('on');
        } else {
            $(this).parent().find('[name="remember"]').val('');
        }
    });
    
    // 输入密码的强弱 password input box keyup event
    $(document).on('keyup', '.mp-sign-form-sign_up input:password', function(e) {
        e = e || window.event;
        var _this = $(this),
            _val  = $(this).val();
        $(_this).val($.trim(_val));
        _this.next('span.h_length').remove();
        
        if ($.trim(_this.val()).length > 5) {
            _this.after("<span class='h_length' strenth-for='" + _this.attr("name") + "' style='display: none;'></span>");
        }
        (function() {
            var e = $.trim(_this.val()),
                t = $("[strenth-for='" + _this.attr("name") + "']");
            return POPBox.passwordRegexp.test(e) ? (/^((\d{6,9})|([a-zA-Z]{6,9})|([^\da-zA-Z]{6,9}))$/.test(e) ? t.text("弱") : /^.{6,9}$/.test(e) ? t.text("中") : t.text("强"), t.show(), void 0) : (t.hide(), void 0)
        })();
    });
    // 输入密码按回车就提交
    $(document).on('keyup', '.mp-sign-form input:password', function(e) {
        e = e || window.event;
        if (e.keyCode == 13) {
            $(this).parents('form').find('.sing-form-submit-btn').trigger('click');
        }
    });
    // 关闭box
    $(document).on('click', '.mppopup-box b.close', function() {
        POPBox.mppopupBoxRemove();
    });
    // esc 关闭box 如何解除事件
    $(document).on('keydown', function(e) {
        e = e || window.event;
        if (e.keyCode === 27) {
            POPBox.mppopupBoxRemove();
        }
    });
    // 检查是否已登录
    $(document).on('click', '.mp-sign', function() {
        POPBox.redirectUrl  = $(this).attr("data-url") || $(this).attr("href") || 'javascript';
        POPBox.redirectUrl  = POPBox.redirectUrl.indexOf('javascript') == -1 ? POPBox.redirectUrl : window.location.href;
        POPBox.redirectUrl  = encodeURI(POPBox.redirectUrl);
        POPBox.isInitSignIn = !($(this).attr('data-init') === "sign_up");

        $.ajax({
            url: '/validations/is_sign_in',
            success: function(data) {
                if(data == 'true') {
                    window.location.href = POPBox.redirectUrl;
                } else {
                    POPBox.mppopupBox();
                }
            },
            cache: false
        });
        return false;
    });

    // 去登录 去注册按钮
    $(document).on('click', '.sign-in_now, .sign-up_now', function(){
        var _isSignIn, _isBox, _fade, _fadeOut;
        _isSignIn = $(this).hasClass('sign-in_now');
        _isBox    = $(this).parents('.mppopup-box').length > 0;
        _fade = '.mp-sign-form-sign_in', _fadeOut = '.mp-sign-form-sign_up';
        if(_isSignIn){
            _fade = '.mp-sign-form-sign_up', _fadeOut = '.mp-sign-form-sign_in';
        }
        if(_isBox){
            $(_fade).fadeOut(function(){
                $(_fadeOut).show();
            });
        } else {
            $(_fade).stop().animate({'opacity': 0, 'right': -500}, 300,function(){
                $(this).css('display', 'none');
                $(_fadeOut).css('display','block').stop().animate({'opacity': 1,'right': '35px'}, 300);
            });
        }
        return false; // 兼容IE8
    });

    // 必须保留 因为ie8不支持placehodler input box focus
    $(document).on('focus', '.mp-sign-form input.mp-sign-blur', function() {
        $(this).addClass('mp-sign-focus');
        $(this).prev('span.sign-placeholder').hide();
    });
    $(document).on('blur', '.mp-sign-form input.mp-sign-blur', function() {
        $(this).removeClass('mp-sign-focus');
    });
    $(document).on('click', '.mp-sign-form span.sign-placeholder', function() {
        $(this).hide().next('input').focus();
    });
    // 登录或注册提交按钮 submit button click
    $(document).on('click', '.sing-form-submit-btn', function() {
        var _form = $(this).parents('form');
        var _this = $(this);
        if (_form.find('div.help-block-error').length == 0) {
            _form.find('input.mp-sign-blur').trigger('blur');
        }
        if (_form.find('div.help-block-error').length != 0) {
            return false;
        } else {
            if ($(this).is('[id="sign-form-submit-sign_in-btn"]')) {
                $.ajax({
                    dataType: "json",
                    type: "post",
                    url: "/validations/sign_in",
                    data: {
                        username: _form.find('[name="user[username]"]').val(),
                        password: _form.find('[name="user[password]"]').val()
                    },
                    beforeSend: function(){
                        _this.attr('disabled', true);
                    },
                    success: function(result) {
                        if(result == '1'){
                            _form.submit();
                        }
                        if(result == '2'){
                            _form.find('[name="user[username]"]').addClass('').after('<div class="help-block-error">用户名不存在</div>');
                            setTimeout(function() {
                                _this.attr('disabled', false);
                            }, 2000);
                        } 
                        if(result == '3'){
                            _form.find('[name="user[password]"]').addClass('').after('<div class="help-block-error">密码不正确</div>');
                            setTimeout(function() {
                                _this.attr('disabled', false);
                            }, 2000);
                        }
                    }
                });
            } else {
                _form.find('input[name="redirect"]').val(POPBox.redirectUrl);
                _form.submit();
            }
        }
    });
    

    // 检测帐号是否存在
    $(document).on('blur', 'input[name="user[username]"], input[name="user[email]"]', function() {
        var _this     = $(this),
            _val      = $.trim($(this).val()),
            _isSignIn = $(this).parents("form").hasClass('mp-sign-form-sign_in'),
            _data     = {
                'case_sensitive' : 'true',
                '_'              : Math.random()
            },
            _name     = $(this).attr('name'),
            _url      = _isSignIn ? '/validations/uniqueness' : '/validators/uniqueness'
            _isEmail  = _name === 'user[email]';

        _data[_name] = _val;
        
        if(_val === '' || _this.next('div.help-block-error').length != 0){
            return;
        }
        $.ajax({
            url: _url,
            type: 'get',
            data: _data,
            statusCode: {
                404: function() {
                    if (_isSignIn) {
                        _this.nextAll('div.help-block-error').remove();
                        _this.after('<div class="help-block-error">你所输入的帐号不存在，请 <a href="javascript:void(0);" class="fblue sign-up_now">注册</a></div>');
                    }
                },
                200: function() {
                    if (!_isSignIn) {
                        if(_isEmail){
                            _this.nextAll('div.help-block-error').remove();
                            _this.after('<div class="help-block-error">该邮箱已存在，请更换邮箱或 <a href="javascript:void(0);" class="fblue sign-in_now">登录</a></div>');
                        } else {
                            _this.nextAll('div.help-block-error').remove();
                            _this.after('<div class="help-block-error">该帐号已存在，请更换帐号或 <a href="javascript:void(0);" class="fblue sign-in_now">登录</a></div>');
                        }
                        // end
                    }
                }
            }
        });
    });
});