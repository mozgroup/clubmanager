default_run_options[:pty] = true
set :rvm_type, :system
set :rvm_ruby_string, ENV['GEM_HOME'].gsub(/.*\//,"")

set :application, "club_manager"
set :repository,  "git@github.com:tadpreston/club_manager.git"
set :scm, :git
set :user, "club_manager"
set :branch, "master"
set :deploy_via, :remote_cache
set :deploy_env, 'production'
set :deploy_to, '~/club_manager'

set :use_sudo, false

# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "ec2-50-112-74-198.us-west-2.compute.amazonaws.com"                   # Your HTTP server, Apache/etc
role :app, "ec2-50-112-74-198.us-west-2.compute.amazonaws.com"                   # This may be the same as your `Web` server
role :db, "ec2-50-112-74-198.us-west-2.compute.amazonaws.com", :primary => true # This is where Rails migrations will run
role :db, "ec2-50-112-74-198.us-west-2.compute.amazonaws.com"

# if you want to clean up old releases on each deploy uncomment this:
after "deploy:restart", "deploy:cleanup"

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end
