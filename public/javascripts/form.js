if (typeof (Stars) === 'undefined') {Stars = {}};

Stars.Form = (function($) {
  var init = function() {
    limitInput();
  };

  var limitInput = function() {
    $('textarea[maxlength]').keyup(function(){
      var input = $(this);
      var max = parseInt(input.attr('maxlength'));
      var text = input.val();
      if(text.length > max){
        input.val(text.substr(0, input.attr('maxlength')));
      }
      input.siblings('.chars_left').html('You have ' + (max - input.val().length) + ' characters left.');
    });
    $('textarea[maxlength]').keyup();
  };

  return {
    init: init
  };
})(jQuery);

$(document).ready(function() {
  Stars.Form.init();
});
