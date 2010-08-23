if (typeof (Stars) === 'undefined') {Stars = {}};

Stars.Scene = (function($) {
  var init = function() {
    $('body').css('min-height', $(window).height());
    $("#stars").scrollingParallax({
    });
  };

  return {
    init: init
  };
})(jQuery);

$(document).ready(function() {
  Stars.Scene.init();
});
