module ApplicationHelper
  def create_a_star_button(text="Make someone a star")
    link_to "&#9733; " + text, new_star_url, :class => 'button'
  end

  def second_button(star, text="Second!")
    if current_user.can_second?(star)
      link_to "&#9732; " + text, star_seconds_url(star),
        :class => 'green_button', :method => :post
    elsif current_user.seconded?(star)
      content_tag(:div,  "&#10003; Seconded", :class => 'seconded round')
    end
  end

  FRIENDLY_TIME_FORMAT = '%H:%M%p on %b %d'
  def friendly_time(time)
    time.getlocal.strftime(FRIENDLY_TIME_FORMAT).
         gsub(/(\s|^)0/, '\\1').
         sub('AM', 'am').
         sub('PM', 'pm')
  end

  DEFAULT_NAME_OPTIONS = {:firstnameonly => true,
                          :linked => false,
                          :useyou => false}
  def default_name_options(user)
    DEFAULT_NAME_OPTIONS.merge(:ifcantsee => user.name.split.first)
  end

  def name(user, opts={})
    user.name
  end

  def linked_name(user, opts={})
    link_to name(user, opts), user_path(user)
  end

  DEFAULT_PHOTO_OPTIONS = {:linked => false,
                           :size => :square}
  def photo(user, opts={})
    link_to(
      fb_profile_pic(user.facebook_uid, DEFAULT_PHOTO_OPTIONS.merge(opts)),
      new_star_url(:to => user.id)
    )
  end

  def linked_photo(user, opts={})
    link_to photo(user, opts), user_path(user)
  end

  def stylesheet(path)
    @stylesheets << path
  end
end
