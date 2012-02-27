module ApplicationHelper
  def create_a_star_button(text="Make someone a star")
    link_to "&#9733; " + text, new_star_url, :class => 'button'
  end

  def create_a_team_button(text="Make a new team")
    link_to "&#9733; " + text, new_team_url, :class => 'button'
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

  PHOTO_SIZE = 50
  def photo(subject)
    type = subject.class.name.downcase
    link_to(image_tag("#{type}.png",
                       :height => PHOTO_SIZE, :width => PHOTO_SIZE),
            send("#{type}_path", subject))
  end

  def stylesheet(path)
    @stylesheets << path
  end
end
