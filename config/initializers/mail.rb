EVERYONE = ENV['MAIL_RECIPIENTS'] || []
ActionMailer::Base.default_url_options[:host] = ENV['APP_HOST'] || ''
