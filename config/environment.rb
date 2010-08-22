RAILS_GEM_VERSION = '2.3.5' unless defined? RAILS_GEM_VERSION

require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  config.time_zone = 'UTC'
  config.gem 'authlogic'
  config.gem 'facebooker'
  config.gem 'hoptoad_notifier'

  config.action_mailer.default_url_options ||= {:host => 'localhost:3000'}
end

