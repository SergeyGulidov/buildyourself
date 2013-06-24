//= require jquery
//= require jquery_ujs
//= require select2
//= require "foundation"
//= require jquery_nested_form
//= require_tree .

$(function(){
        var $container = $('#container');
        $container.imagesLoaded(function(){
          $container.masonry({
            itemSelector : '.item'
          });
        });
});


$(document).foundation('orbit');
$(document).foundation('section');
$(document).foundation('reveal');
$(document).foundation('clearing',
	{
			close_selectors : '.visible-img, .clearing-close'
	});








