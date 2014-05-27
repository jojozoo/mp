/*
popup login
 */
$(function() {
    var userLoginInfo = null;
    var isIE6 = false;
    var lastAccountValue = '';
    var targetLocation = window.location.href;
    var hostname = window.location.hostname;
    var passwordReg = /^\s*[\@A-Za-z0-9\!\#\$\%\^\&\*\.\~]{5,16}\s*$/;
    //创建登录框
    //样式表
    window.popupFrameCreate = function(gotoPage, $obj) {
        var frameHtml = '',
            cfgStyle = '',
            cfgRegTitleHtml = '',
            cfgLoginTitleHtml = '',
            regNameTip = '',
            regAcountTip = '',
            regPassTip = '';
        var regTitle = $obj.attr('data-reg-html') || '快速注册漫拍网';
        var arrRegPlaceHolder = ['帐号', '邮箱', '密码'];
        var arrDataPlaceHolder = $obj.attr('data-reg-placeholder') ? $obj.attr('data-reg-placeholder').split(',') : arrRegPlaceHolder;
        gotoPage = gotoPage || targetLocation;
        gotoPage = encodeURI(gotoPage);
        //已经存在
        if ($('#mp-popup-login').length != 0) {
            frameShow();
        }
        //不存在，创建
        else {
            var styleCode = '<style type="text/css"></style>';
            $('head').append(styleCode);
            frameHtml += '<div id="mp-popup-login" data-target="' + gotoPage + '"><div class="pop-left"><div class="pop-left-con"><div class="pop-login"><h3>立即登录</h3><form method="post" action="http://mpwang.cn/sign_in" id="mp-pop-login-form"><ul><li><span class="inputTip">输入帐号/邮箱/手机</span><input type="text" place-holder="正确帐号邮箱或手机" name="account[email_or_mobile]" class="txt" regtype="email_mobile,notnull" id="mp-login-email_or_mobile" tabindex="100" /></li><li><span class="inputTip">输入登录密码</span><input type="password" place-holder="密码" name="account[password]" class="txt" regtype="notnull" maxlength="16" tabindex="101" /></li><li><input type="hidden" name="remember" /><input type="hidden" name="return_to" value="' + gotoPage + '" /><label class="checked">保持登录状态</label> <a href="http://mpwang.cn/find_pwd" class="get-back-password" target="_blank" title="找回密码">找回密码</a></li><li><input type="button" id="mp-popup-login-btn" class="mp-submit-btn" value="" tabindex="102" />      <a href="http://mpwang.cn/sign_up" class="fblue reg-now" target="_blank">没有帐号，立即注册</a></li></ul></form></div><div class="pop-reg"><h3>' + regTitle + '</h3><form method="post" action="http://mpwang.cn/account/accounts" id="mp-pop-reg-form"><ul><li><span class="inputTip">' + arrDataPlaceHolder[0] + '</span><input type="text" place-holder="帐号" name="account[name_native_display]" class="txt" regType="chinese,notnull" tabindex="200" /></li><li><span class="inputTip">' + arrDataPlaceHolder[1] + '</span><input type="text" place-holder="正确邮箱" name="account[email_or_mobile]" class="txt" regtype="email_mobile,notnull" id="mp-reg-email_or_mobile" tabindex="201" /></li><li><span class="inputTip">' + arrDataPlaceHolder[2] + '</span><input type="password" place-holder="密码" name="account[password]" class="txt" regtype="notnull" maxlength="16" tabindex="202" /></li><li><input type="button" id="mp-popup-reg-btn" class="mp-submit-btn" value="" tabindex="203" /><a href="http://mpwang.cn/sing_in" class="fblue login-now" target="_blank">已有帐号，直接登录</a></li></ul><input type="hidden" name="landing_page" value="popup" /><input type="hidden" name="parameters" /><input type="hidden" name="keyword" /><input type="hidden" name="data-target" /></form></div></div></div><div class="pop-right"><div class="pop-right-con"><p>使用社交帐号登录</p><a href="/oauth/weibo" class="weiboLogin" title="用新浪微博登录">用新浪微博登录</a></div></div><div style="clear:both;"></div><b class="close" title="关闭"></b></div><div id="mp-popup-login-outer-shade"></div><div id="mp-popup-login-shade"><iframe src="about:blank" border="0" frameborder="0" scrolling="no" style="width:100%;height:' + $(document).height() + 'px;background:transparent;"></iframe></div>';
            $('body').append(frameHtml);
            if (isIE6) {
                $('#mp-popup-login,#mp-popup-login-outer-shade').css({
                    top: document.documentElement.scrollTop + 150
                });
                $(window).scroll(function() {
                    $('#mp-popup-login,#mp-popup-login-outer-shade').css('top', document.documentElement.scrollTop + 150);
                });
            }
            setTimeout(function() {
                if ($('[name="account[email_or_mobile]"]').val() !== '') {
                    $('[name="account[email_or_mobile]"],[name="account[password]"]').val('');
                }
            }, 1000);

        }
    }
    //隐藏登录框
    function frameHide() {
        $('#mp-popup-login,#mp-popup-login-shade,#mp-popup-login-outer-shade').remove();
    }
    //显示登录框
    function frameShow() {
        $('#mp-popup-login,#mp-popup-login-shade,#mp-popup-login-outer-shade').show();
    }

    //前端校验
    function regInput(obj, value, msg, type) {
        var sRuleMsg = '';
        var bFail = false;
        var oResult = [];
        switch (type) {
            case 'notnull':
                if (value !== '') {
                    bFail = true;
                }
                break;
            case 'email_mobile':
                var emailPhoneReg = /^\s*(([a-zA-Z0-9]+([\._\-][a-zA-Z0-9]+)*@[a-zA-Z0-9]+([_\-][a-zA-Z0-9]+)*(\.[a-zA-Z0-9]+([_\-][a-zA-Z0-9]+)*)+)|(\d{11}))\s*$/;
                bFail = emailPhoneReg.test(value);
                break;
            case 'chinese':
                var chineseReg = /^\s*([\u4E00-\u9FA5]{2,5}(?:·[\u4E00-\u9FA5]{2,5})*|[a-zA-Z]{2,20}(\s+[a-zA-Z]{2,20})+)\s*$/;
                var chineseReg1 = /^\s*([\u4E00-\u9FA5]{2,5}(?:·[\u4E00-\u9FA5]{2,5})*|[a-zA-Z][\sa-zA-Z]{3,63})\s*$/;
                bFail = chineseReg.test(value) && chineseReg1.test(value);
                break;
            case 'password':
                bFail = /^\s*[\@A-Za-z0-9\!\#\$\%\^\&\*\.\~]{6,16}\s*$/.test(value);
                break;
        }
        obj.next('div.popup-error').remove();
        if (!bFail) {
            if (obj.val() === '') {
                obj.prev('span.inputTip').show();
            }
            if (obj.attr('type') === 'password') {
                if (obj.parents('form').attr('id') === 'mp-pop-login-form') {
                    obj.after('<div class="popup-error">请输入密码</div>');
                } else {
                    obj.after('<div class="popup-error">请设置6-16位英文字母，数字，符号密码</div>');
                }

            } else {
                obj.after('<div class="popup-error">请输入' + msg + '</div>');
            }
        }
    }
    //手机、邮箱
    $('body').on('blur', '#mp-popup-login input:text,#mp-popup-login input:password', function() {
        var val = $.trim($(this).val());
        var aReg = $(this).attr('regtype').split(',');
        $(this).nextAll('div.popup-error').remove();
        for (var i = 0; i < aReg.length; i++) {
            if (aReg[i] === 'notnull' && val !== '') {
                if ($(this).attr('type') === 'password' && !passwordReg.test(val)) {
                    if ($(this).parents('form').is('[id="mp-pop-reg-form"]')) {
                        $(this).after('<div class="popup-error">请设置6-16位英文字母，数字，符号密码</div>');
                    } else {
                        $(this).after('<div class="popup-error">密码长度应该在6-16位之间，且为英文、数字或符号</div>');
                    }
                }
                break;
            }
            regInput($(this), val, $(this).attr('place-holder'), aReg[i]);
        }
    });
    //Checkbox
    $('body').on('click', '#mp-popup-login .pop-left-con label', function() {
        $(this).toggleClass('checked');
        if ($(this).hasClass('checked')) {
            $(this).parent().find('[name="remember"]').val('on');
        } else {
            $(this).parent().find('[name="remember"]').val('');
        }
    });
    //password input box keyup event
    $('body').on('keyup', '#mp-popup-login .pop-reg input:password', function(e) {
        e = e || window.event;
        var $this = $(this);
        $(this).val($(this).val().replace(/\s+/g, ''));
        if ($this.next('span.h_length').length != 0) {
            $this.next('span.h_length').remove();
        }
        var showStrengthTips = function() {
            var e = $.trim($this.val()),
                t = $("[strenth-for='" + $this.attr("name") + "']");
            return /^\s*[\@A-Za-z0-9\!\#\$\%\^\&\*\.\~]{6,16}\s*$/.test(e) ? (/^((\d{6,9})|([a-zA-Z]{6,9})|([^\da-zA-Z]{6,9}))$/.test(e) ? t.text("弱") : /^.{6,9}$/.test(e) ? t.text("中") : t.text("强"), t.show(), void 0) : (t.hide(), void 0)
        }
        if ($.trim($this.val()).length > 5) {
            $this.after("<span class='h_length' strenth-for='" + $this.attr("name") + "' style='display: none;'></span>");
        }
        showStrengthTips();
    });
    $('body').on('keyup', '#mp-popup-login input:password', function(e) {
        e = e || window.event;
        if (e.keyCode == 13) {
            $(this).parents('form').find('.mp-submit-btn').trigger('click');
        }
    });


    //已有帐号立即登录
    $('body').on('click', '#mp-popup-login .login-now', function() {
        return frameMove('#mp-popup-login .pop-reg', '#mp-popup-login .pop-login', 'login');
    });
    //没有帐号，转到注册
    $('body').on('click', '#mp-popup-login .reg-now', function() {
        return frameMove('#mp-popup-login .pop-login', '#mp-popup-login .pop-reg', 'reg');
    });


    $('body').on('click', '#mp-popup-login b.close', function() {
        frameHide();
    });
    //esc hide the box
    $(document).keydown(function(e) {
        e = e || window.event;
        if (e.keyCode === 27) {
            frameHide();
        }
    });

    //input box focus
    $('body').on('focus', '#mp-popup-login .pop-left-con ul li input.txt', function() {
        $(this).addClass('focus');
        $(this).prev('span.inputTip').hide();
    });
    $('body').on('blur', '#mp-popup-login .pop-left-con ul li input.txt', function() {
        $(this).removeClass('focus');
    });
    $('body').on('click', '#mp-popup-login span.inputTip', function() {
        $(this).hide().next('input').focus();
    });

    //注册、登录移动
    function frameMove(target1, target2, type) {
        $(target1).fadeOut(function() {
            $(target2).show();
        });
        return false;
    }
    //cross domain
    /*function getUserInfo($$) {
        if ( !! $$) {
            //用户信息
            $$.ajax({
                url: 'http://mpwang.cn/front/nav/user',
                success: function(data) {
                    userLoginInfo = data;
                },
                rsync: false,
                cache: false
            });
        }
    }*/
    if ($('#crossdomain-iframe').length === 0 && !! hostname && hostname.indexOf('mpwang.cn') != -1) {
        var config = {
            domain: hostname.substring(hostname.indexOf('.') + 1),
            crossDomainFrameUrl: 'http://mpwang.cn/crossdomain.html',
            crossDomainFrameId: 'crossdomain-iframe'
        };
        if (hostname == 'mpwang.cn') {
            config.crossDomainFrameUrl = 'http://mpwang.cn/crossdomain.html'
        }
        var thisDomain = hostname.match(/[a-z]+/)[0];
        var ridDomain = config.crossDomainFrameUrl.match(/[a-z]+/g)[1];
        var crossDom;
        //set domain
        if (hostname != 'www.mpwang.cn' && hostname != 'mpwang.cn') {
            document.domain = 'mpwang.cn';
        }
        if (thisDomain != ridDomain) {
            var frame = document.createElement('iframe'),
                frameQuery;
            frame.src = config.crossDomainFrameUrl;
            frame.id = config.crossDomainFrameId;
            frame.style.display = 'none';
            document.body.appendChild(frame);
            if (isIE6 || frame.attachEvent) {
                frame.attachEvent('onload', function() {
                    window.__$ = document.getElementById(config.crossDomainFrameId).contentWindow.$;
                    //getUserInfo(__$);
                });
            } else {
                frame.onload = function() {
                    window.__$ = document.getElementById(config.crossDomainFrameId).contentWindow.$;
                    //getUserInfo(__$);
                }
            }
        }/* else {
            getUserInfo($);
        }*/
    }
    if (!window.__$) {
        window.__$ = $;
    }
    //submit button click
    $('body').on('click', '#mp-popup-login .mp-submit-btn', function() {
        var $thisForm = $(this).parents('form');
        var $this = $(this);
        var canSubmit = true;
        var returnTarget = $('#mp-popup-login').attr('data-target');
        returnTarget = returnTarget && returnTarget.indexOf('http:') == -1 ? 'http://' + hostname + returnTarget : returnTarget;
        $thisForm.find('input.txt[name!="account[email_or_mobile]"]').trigger('blur');

        if ($thisForm.find('[name="account[email_or_mobile]"]').next('div.popup-error').length == 0) {
            $thisForm.find('[name="account[email_or_mobile]"]').trigger('blur');
        }
        if ($thisForm.find('div.popup-error').length != 0) {
            return false;
        } else {
            if ($(this).is('[id="mp-popup-login-btn"]')) {
                $(this).attr('disabled', true);
                __$.ajax({
                    dataType: "json",
                    type: "post",
                    url: "http://mpwang.cn/index/login",
                    data: {
                        "account[email_or_mobile]": $thisForm.find('[name="account[email_or_mobile]"]').val(),
                        "account[password]": $thisForm.find('[name="account[password]"]').val()
                    },
                    success: function(result) {
                        if (result.status == -1) {
                            $thisForm.find('[name="account[password]"]').after('<div class="popup-error">' + result.msg + '</div>');
                            setTimeout(function() {
                                $this.attr('disabled', false);
                            }, 2000);
                        } else {
                            //window.location.href = returnTarget;
                            $thisForm.submit();
                        }
                    }
                });
            } else {
                $('#mp-popup-login .pop-reg input[name="parameters"]').val(window.location.search.substring(1));
                $thisForm.find('input[name="data-target"]').val(returnTarget);
                if ($('meta[name="Keywords"]')) {
                    $('#mp-popup-login .pop-reg input[name="keyword"]').val($('meta[name="Keywords"]').attr('content'));
                }
                $thisForm.submit();
            }
        }
    });
    //添加事件
    $('body').on('click', '.popup-login', function() {
        var $this = $(this);
        __$.ajax({
            url: '/ajax/is_sign_in',
            success: function(data) {
                if (!data['error']) {
                    if ($this.is('a')) {
                        if ($this.attr('href').indexOf('http://') != -1) {
                            window.location.href = $this.attr('href');
                        } else if ($this.attr('href').indexOf('javascript') != -1) {
                            if ($this.attr('data-target')) {
                                window.location.href = $this.attr('data-target');
                            } else {
                                window.location.reload();
                            }
                        } else {
                            window.location.href = 'http://' + hostname + $this.attr('href');
                        }
                    } else {
                        if ($this.attr('data-target')) {
                            window.location.href = $this.attr('data-target');
                        } else {
                            window.location.reload();
                        }
                    }
                } else {
                    var returnTarget = '';
                    if ($this.attr('data-target')) {
                        returnTarget = $this.attr('data-target');
                    } else {
                        if ($this.is('a')) {
                            returnTarget = $this.attr('href');
                            if (returnTarget.indexOf('http:') == -1) {
                                if ($this.attr('href').indexOf('javascript') != -1) {
                                    returnTarget = window.location.href;
                                } else {
                                    returnTarget = 'http://' + hostname + returnTarget;
                                }
                            }
                            //returnTarget = returnTarget.indexOf('http:') == -1 ? 'http://' + hostname + returnTarget : returnTarget;
                        } else {
                            returnTarget = window.location.href;
                        }
                    }
                    if ($this.attr('data-init') && $this.attr('data-init') === 'register') {
                        var target = returnTarget || 'http://mpwang.cn/home';
                        popupFrameCreate(target, $this);
                        $('#mp-popup-login .pop-login').hide();
                        $('#mp-popup-login .pop-reg').show();
                    } else {
                        popupFrameCreate(returnTarget, $this);
                    }
                    if ($this.attr('data-checked') && $this.attr('data-checked') === 'false') {
                        $('#mp-popup-login .pop-left-con label').removeClass('checked');
                        $('#mp-popup-login').find('[name="remember"]').val('');
                    } else {
                        $('#mp-popup-login').find('[name="remember"]').val('on');
                    }
                    return false;
                }
            },
            cache: false
        });
        // __$.ajax({
        //     url: 'http://mpwang.cn/popup_signup_log',
        //     type: 'post'
        // });
        return false;
    });

    //检测帐号是否存在
    $('body').on('blur', 'input[name="account[email_or_mobile]"]', function() {
        var $this = $(this),
            thisVal = $.trim($(this).val());
        if (thisVal !== '' && $this.next('div.popup-error').length == 0) {
            __$.ajax({
                url: 'http://mpwang.cn/validators/account_unique',
                type: 'get',
                data: {
                    email_or_mobile: $this.val()
                },
                statusCode: {
                    200: function() {
                        $('input[name="account[email_or_mobile]"]').prev('span.inputTip').hide().end().val($this.val()).next('div.popup-error').remove();
                        if ($this.attr('id') === 'mp-login-email_or_mobile') {
                            if ($this.next('div.popup-error').length !== 0) {
                                $this.next('div.popup-error').html('你所输入的帐号不存在，请 <a href="javascript:void(0);" class="fblue reg-now">注册</a>');
                            } else {
                                $this.after('<div class="popup-error">你所输入的帐号不存在，请 <a href="javascript:void(0);" class="fblue reg-now">注册</a></div>');
                            }
                        }
                    },
                    201: function() {
                        $('input[name="account[email_or_mobile]"]').prev('span.inputTip').hide().end().val($this.val()).next('div.popup-error').remove();
                        if ($this.attr('id') === 'mp-reg-email_or_mobile') {
                            if ($this.next('div.popup-error').length !== 0) {
                                $this.next('div.popup-error').html('该帐号已存在，请更换帐号或 <a href="javascript:void(0);" class="fblue login-now">登录</a>');
                            } else {
                                $this.after('<div class="popup-error">该帐号已存在，请更换帐号或 <a href="javascript:void(0);" class="fblue login-now">登录</a></div>');
                            }
                        }
                    }
                }
            });
        }
    });

    //自动弹出登录框
    $('.popup-login[data-auto-popup=true]').each(function() {
        $(this).trigger('click');
        //popupFrameCreate($(this).attr('data-target'), $(this));
        if ($(this).attr('data-init') == 'register') {
            $('#mp-popup-login .pop-login').hide();
            $('#mp-popup-login .pop-reg').show();
        }
        return false;
    });
});