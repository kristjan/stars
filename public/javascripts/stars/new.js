if (typeof (Stars) === 'undefined') {Stars = {}};

Stars.New = (function($) {
  var init = function() {
    setSelected();
    $('form li').click(selectUser);
  };

  var selectUser = function(e) {
    e.preventDefault();
    var li = $(this);
    li.siblings().removeClass('selected');
    li.addClass('selected');
    li.find('input:radio').attr('checked', true);
  };

  var setSelected = function() {
    radio = $('#new_star input:radio:checked').parent().addClass('selected');
  }

  return {
    init: init
  };
})(jQuery);

$(document).ready(function() {
  Stars.New.init();
});
