set :application, "SerienDB-RAN"
set :repository,  "git@github.com:nostrowski/SerienDB.git"

set :deploy_to, "/u/apps/#{application}"

set :user, "root"

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "192.168.2.82"     # Your HTTP server, Apache/etc
role :app, "192.168.2.82"     # This may be the same as your `Web` server
role :db,  "192.168.2.82", :primary => true # This is where Rails migrations will run

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end
