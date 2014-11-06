# config valid only for Capistrano 3.1
lock '3.2.1'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app
# set :deploy_to, '/var/www/my_app'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty
set :application, "spree-clean"
set :repo_url,  "git@github.com:cplopez4/spree-clean.git"
set :scm, :git

#server = "llamazo.cloudapp.net"

# role :web, server
# role :app, server
# role :db,  server, :primary => true # This is where Rails migrations will run

set :user, "spree"

set :deploy_to, "/home/spree/spree-clean"
set :use_sudo, true

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :images do
  task :symlink do
    execute "rm -rf #{release_path}/public/spree"
    execute "ln -nfs #{shared_path}/spree #{release_path}/public/spree"
  end
end

after "deploy:bundle", "images:symlink"

namespace :unicorn do

  desc "Zero-downtime restart of Unicorn"
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute "kill -s USR2 `cat /tmp/unicorn.spree-clean.pid`"
    end
  end

  desc "Start unicorn"
  task :start do
    on roles(:app), in: :sequence, wait: 5 do
      execute "cd #{current_path} ; bundle exec unicorn_rails -c config/unicorn.rb -D -E production"
    end
  end

  desc "Stop unicorn"
  task :stop do
    on roles(:app), in: :sequence, wait: 5 do
      execute "kill -s QUIT `cat /tmp/unicorn.spree-clean.pid`"
    end
  end
end

after "deploy:restart", "unicorn:restart"

task :symlink_database_yml do
  execute "rm #{release_path}/config/database.yml"
  execute "ln -sfn #{shared_path}/config/database.yml #{release_path}/config/database.yml"
end
after "deploy:bundle", "symlink_database_yml"

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end
