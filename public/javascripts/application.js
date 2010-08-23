if (typeof (Stars) === 'undefined') {Stars = {}};

Stars.Scene = (function($) {
  var init = function() {
    $("#stars, #logo").scrollingParallax({
      bgHeight: '100%',
      bgWidth: '100%',
      enableHorizontal: true,
      staticSpeed: 0.3,
      staticSpeedX: 0.1
    });
  };

  return {
    init: init
  };
})(jQuery);

$(document).ready(function() {
  Stars.Scene.init();
});
