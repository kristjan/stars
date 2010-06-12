ActionMailer::Base.default_content_type = 'text/html'

class Mailer < ActionMailer::Base
  def star(star)
    subject "You got a star!"
    recipients star.to.email
    from 'Stars'
    body :star => star
  end

  def report
    subject "State of the Causemos - #{Date.today.strftime('%B %d, %Y')}"
    recipients EVERYONE
    from 'The King of All Causemos'
    body :stars_by_user => Star.past_week_by_user
  end
end
