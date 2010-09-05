if (typeof (Stars) === 'undefined') {Stars = {}};

Stars.New = (function($) {
  var init = function() {
    setSelected();
    $('form li').click(selectUser);
    limitReason();
  };

  var limitReason = function() {
    $('textarea[maxlength]').keyup(function(){
      var input = $(this);
      var max = parseInt(input.attr('maxlength'));
      var text = input.val();
      if(text.length > max){
        input.val(text.substr(0, input.attr('maxlength')));
      }
      input.siblings('.chars_left').html('You have ' + (max - input.val().length) + ' characters left.');
    });
  };

  var selectUser = function() {
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
