default_run_options[:pty] = true
set :rvm_type, :system
set :rvm_ruby_string, 'ruby-1.9.3-p327'

set :application, "club_manager"
set :repository,  "git@github.com:tadpreston/club_manager.git"
set :scm, :git
set :user, "club_manager"
set :branch, "master"
set :deploy_via, :remote_cache
set :deploy_env, 'production'
set :deploy_to, '/home/club_manager/club_manager'

set :use_sudo, true

# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "54.245.235.16"                   # Your HTTP server, Apache/etc
role :app, "54.245.235.16"                   # This may be the same as your `Web` server
role :db, "54.245.235.16", :primary => true # This is where Rails migrations will run
role :db, "54.245.235.16"

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
