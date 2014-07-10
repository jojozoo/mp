/*!
 * (c) Tunghsiao Liu.
 *
 * path-menu - v1.1.1 (06-26-2014)
 * http://sparanoid.com/lab/path-menu/
 * MIT - http://github.com/sparanoid/path-menu/blob/master/LICENSE
 */(function(){$(".flyout-btn").click(function(){return $(".flyout-btn").toggleClass("btn-rotate"),$(".flyout").find("a").removeClass(),$(".flyout").removeClass("flyout-init fade").toggleClass("expand")}),$(".flyout").find("a").click(function(){return $(".flyout-btn").toggleClass("btn-rotate"),$(".flyout").removeClass("expand").addClass("fade"),$(this).addClass("clicked")})}).call(this);
