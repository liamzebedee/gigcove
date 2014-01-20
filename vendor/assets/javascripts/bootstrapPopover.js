/*
 * Bootstrap Popover v0.0.1
 * License: MIT
 * Author: Liam Edwards-Playne <liamz.co>
 */
(function($) {
	$.fn.createPopover = function(content) {
		if(!$(this).data('hasParent')) {
			$(this).wrap($('<span rel="popover" class="bootstrapPopover"></span>'));
			$(this).data('hasParent', true);
		}
		
		var wrapper = $(this).parent();
		
		wrapper.popover({
			placement: 'bottom',
			selector: '[rel="popover"]',
			container: wrapper,
			content: content,
			trigger: 'manual'
		});
		
		$(this).on('focus', function(){ wrapper.popover('hide'); });
		wrapper.popover('show');
	};
})(jQuery);
