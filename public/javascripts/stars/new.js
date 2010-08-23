if (typeof (Stars) === 'undefined') {Stars = {}};

Stars.New = (function($) {
  var init = function() {
    $('form li').click(selectUser);
  };

  var selectUser = function() {
    var li = $(this);
    li.siblings().removeClass('selected');
    li.addClass('selected');
    li.find('input:radio').attr('checked', true);
  };

  return {
    init: init
  };
})(jQuery);

$(document).ready(function() {
  Stars.New.init();
});
