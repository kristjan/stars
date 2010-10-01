if (typeof (Stars) === 'undefined') {Stars = {}};

Stars.New = (function($) {
  var init = function() {
    setSelected();
    $('form li').click(clickedUser);
  };

  var clickedUser = function(e) {
    e.preventDefault();
    var li = $(this);
	var cb = li.find('input:checkbox');
	cb.attr('checked', !cb.attr('checked'));
    li.toggleClass('selected', cb.attr('checked'));
  };

  var setSelected = function() {
    $('#new_star input:checkbox:checked').parent().addClass('selected');
  }

  return {
    init: init
  };
})(jQuery);

$(document).ready(function() {
  Stars.New.init();
});
