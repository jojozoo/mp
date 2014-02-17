$(function() {
	//*  charts

	//* small gallery grid
	zhu_gal_grid.small();
	//* slidebar
	gebo_sidebar.init();
	//* main menu mouseover
	zhu_nav_mouseover.init();
	//* to top
	$().UItoTop({inDelay:200,outDelay:200,scrollSpeed: 500});
	gebo_tag_handler.init();
	// stick
	$.sticky("bar 1 callback", {autoclose : false, position: "bottom-right", type: "st-info" });
	$.sticky("bar 2 callback", {autoclose : false, position: "bottom-right", type: "st-success" });
	$.sticky("bar 3 callback", {autoclose : false, position: "bottom-right", type: "st-error" });
});
function is_touch_device() {
	return !!('ontouchstart' in window);
}

//* tag handler
gebo_tag_handler = {
	init: function() {
		$("#array_tag_handler").tagHandler({
			assignedTags: [ 'C', 'Perl', 'PHP' ],
			availableTags: [ 'C', 'C++', 'C#', 'Java', 'Perl', 'PHP', 'Python' ],
			autocomplete: true
		});
		$("#max_tags_tag_handler").tagHandler({
			assignedTags: [ 'Perl' ],
			availableTags: [ 'C', 'C++', 'C#', 'Java', 'Perl', 'PHP', 'Python' ],
			autocomplete: true,
			maxTags:5
		});
	}
};
//* gallery grid
zhu_gal_grid = {
	small: function() {
		//* small gallery grid
		$('#small_grid ul').imagesLoaded(function() {
			// Prepare layout options.
			var options = {
				autoResize: true, // This will auto-update the layout when the browser window is resized.
				container: $('#small_grid'), // Optional, used for some extra CSS styling
				offset: 6, // Optional, the distance between grid items
				itemWidth: 120, // Optional, the width of a grid item (li)
				flexibleItemWidth: false
			};
			
			// Get a reference to your grid items.
			var handler = $('#small_grid ul li');
			
			// Call the layout function.
			handler.wookmark(options);
			
			$('#small_grid ul li > a').attr('rel', 'gallery').colorbox({
				maxWidth	: '80%',
				maxHeight	: '80%',
				opacity		: '0.2', 
				loop		: false,
				fixed		: true
			});
		});
	}
};

//* main menu mouseover
zhu_nav_mouseover = {
	init: function() {
		$('header li.dropdown').mouseenter(function() {
			if($('body').hasClass('menu_hover')) {
				$(this).addClass('navHover')
			}
		}).mouseleave(function() {
			if($('body').hasClass('menu_hover')) {
				$(this).removeClass('navHover open')
			}
		});
		$('header li.dropdown > a').click(function(){
			if($('body').hasClass('menu_hover')) {
				window.location = $(this).attr('href');
			}
		});
	}
};

gebo_sidebar = {
	init: function() {
		//* sidebar visibility switch
		$('.sidebar_switch').click(function(){
			$('.sidebar_switch').removeClass('on_switch off_switch');
			if( $('body').hasClass('sidebar_hidden') ) {
				$('body').removeClass('sidebar_hidden');
				$('.sidebar_switch').addClass('on_switch').show();
				$('.sidebar_switch').attr( 'title', "Hide Sidebar" );
			} else {
				$('body').addClass('sidebar_hidden');
				$('.sidebar_switch').addClass('off_switch');
				$('.sidebar_switch').attr( 'title', "Show Sidebar" );
			};
			//gebo_sidebar.update_scroll();
			$(window).resize();
		});
		
	}
};