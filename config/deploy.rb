set :application, "SerienDB-RAN"
set :repository,  "git@github.com:nostrowski/SerienDB.git"

set :deploy_to, "/u/apps/#{application}"

set :user, "root"

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "83.169.23.219"     # Your HTTP server, Apache/etc
role :app, "83.169.23.219"     # This may be the same as your `Web` server
role :db,  "83.169.23.219", :primary => true # This is where Rails migrations will run

ssh_options[:forward_agent] = true
set :deploy_via, :remote_cache

after "deploy:finalize_update", "deploy:custom_deployment"

namespace :deploy do
  desc "Things to do after deployment"
  task :custom_deployment do
    set_permissions
  end

  desc "Set permissions"
  task :set_permissions do
    run "chown -R nobody:nogroup /u/apps/"
  end

  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end
 
  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end
end