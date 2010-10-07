if (typeof (Stars) === 'undefined') {Stars = {}};

Stars.New = (function($) {
  var init = function() {
    setSelected();
    $('form li.user').click(clickedUser);
    $('form li.team').click(clickedTeam);
  };

  var clickedUser = function(e) {
    e.preventDefault();
    var li = $(this);
    var cb = li.find('input:checkbox');
    cb.attr('checked', !cb.attr('checked'));
    setSelected();
  };

  /* TODO - iterate the checkboxes once and do the right thing instead of
 * de-styling them all en masse and then re-styling them after */
  var setSelected = function() {
    $('input:checkbox').parent().removeClass('selected teamSelected');
    $('li.user input:checkbox:checked').parent().addClass('selected');
    $('li.team input:checkbox:checked')
      .each( function() {
        memberCheckboxesForTeamCheckbox($(this)).parent().addClass('teamSelected');
      })
      .parent().addClass('teamSelected')
  }

  var clickedTeam = function(e) {
    e.preventDefault()
    /* cb:  checkbox representing the on/off state of the team.
      cb itself is ignored by the controller, it's just there to
      hang a list of user ids onto
    */
    cb = $(this).find('input:checkbox');
    checked = cb.attr('checked') ? '' : 'checked';
    cb.attr('checked', checked);

    memberCheckboxesForTeamCheckbox(cb).attr('checked', checked);
    setSelected();
  };

  var memberCheckboxesForTeamCheckbox = function(tcb) {
    var matched = jQuery();
    $.each(tcb.val().split(','), function (i,m) {
      matched = matched.add('input#star_to_ids_' + m);
    });
    return matched;
  };

  return {
    init: init
  };
})(jQuery);

$(document).ready(function() {
  Stars.New.init();
});
