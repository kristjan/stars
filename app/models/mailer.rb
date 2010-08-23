ActionMailer::Base.default_content_type = 'text/html'

class Mailer < ActionMailer::Base
  def star(star)
    subject "#{star.to.name} got a star!"
    recipients EVERYONE
    from 'Stars'
    body :star => star
  end

  def report
    this_monday = Date.today.beginning_of_week
    last_monday = this_monday - 1.week
    stars = Star.during(last_monday..this_monday)
    num_stars = stars.size
    num_tos = stars.map(&:to_id).uniq.size
    num_froms = stars.map(&:from_id).uniq.size

    subject "Superstars - #{this_monday.strftime('%B %d, %Y')}"
    recipients EVERYONE
    from 'The King of All Causemos'

    body :superstars => User.superstars_for(last_monday),
         :num_stars => num_stars, :num_tos => num_tos,
         :num_froms => num_froms
  end
end
