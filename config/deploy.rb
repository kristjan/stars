set :application, "stars"
set :repository,  "git@github.com:kristjan/#{application}.git"

set :scm, :git
set :deploy_to, "/var/www/#{application}"
set :use_sudo, false

role :web, "#{application}.kripet.us"                   # Your HTTP server, Apache/etc
role :app, "#{application}.kripet.us"                   # This may be the same as your `Web` server
role :db,  "#{application}.kripet.us", :primary => true # This is where Rails migrations will run
role :db,  "#{application}.kripet.us"

default_environment["PATH"] = "/var/lib/gems/1.8/bin:/usr/local/bin:/usr/bin:/bin"

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  task :configure do
    run "cp -r #{deploy_to}/shared/config/* #{release_path}/config/"
  end
  after "deploy:update_code", "deploy:configure"
end


Dir[File.join(File.dirname(__FILE__), '..', 'vendor', 'gems', 'hoptoad_notifier-*')].each do |vendored_notifier|
  $: << File.join(vendored_notifier, 'lib')
end

require 'hoptoad_notifier/capistrano'
