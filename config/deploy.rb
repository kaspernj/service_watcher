# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'servicewatcher'
set :repo_url, 'https://github.com/kaspernj/service_watcher.git'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app
# set :deploy_to, '/var/www/my_app'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
set :pty, true

# Default value for :linked_files is []
set :linked_files, ["config/database.yml", "config/smtp.yml"]

# Default value for linked_dirs is []
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Whenever config used to update cron to run checks.
set :whenever_roles,        ->{ :db }
set :whenever_command,      ->{ [:bundle, :exec, :whenever] }
set :whenever_command_environment_variables, ->{ {} }
set :whenever_identifier,   ->{ fetch :application }
set :whenever_environment,  ->{ fetch :rails_env, "production" }
set :whenever_variables,    ->{ "environment=#{fetch :whenever_environment}" }
set :whenever_update_flags, ->{ "--update-crontab #{fetch :whenever_identifier} --set #{fetch :whenever_variables}" }
set :whenever_clear_flags,  ->{ "--clear-crontab #{fetch :whenever_identifier}" }
require 'whenever/capistrano'

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:web), in: :sequence, wait: 5 do
      execute :sudo, "apache2ctl graceful"
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      within release_path do
        with rails_env: fetch(:rails_env) do
          puts "Updating plugins."
          execute :rake, 'update_plugins'

          puts "Updating reporter plugins."
          execute :rake, 'update_reporter_plugins'
        end
      end
    end
  end
end
