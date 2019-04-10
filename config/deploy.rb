# config valid for current version and patch releases of Capistrano
lock "~> 3.11.0"

SSHKit.config.command_map[:rake] = 'bundle exec rake'

set :application, "prelaunchr"
set :repo_url, "git@github.com:Physicianlaboratories/prelaunchr.git"

set :use_sudo, false
set :deploy_via, :copy
set :keep_releases, 5

set :log_level, :debug
set :pty, false

set :rvm_type, :user
set :default_env, { rvm_bin_path: '~/.rvm/bin' }

set :linked_files, %w(config/database.yml .env)
set :linked_dirs, %w(log tmp/pids tmp/cache tmp/sockets)


namespace :deploy do
  task :setup do
    on roles(:all) do
      execute "mkdir -p #{deploy_to}/shared/config/"
      upload!("config/database.#{fetch(:branch)}.yml", "#{deploy_to}/shared/config/database.yml")
      upload!(".env.#{fetch(:branch)}", "#{deploy_to}/shared/.env")
    end
    on roles(:app) do
      execute "ln -sf #{shared_path}/config/database.yml #{current_path}/config/database.yml"
      execute "ln -sf #{shared_path}/.env #{current_path}/.env"
    end
  end

  task :seed do
    on primary fetch(:migration_role) do
      within release_path do
        with rails_env: fetch(:rails_env)  do
          execute :rake, 'db:seed'
        end
      end
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:web), wait: 5 do
      execute '/etc/init.d/web_platform', 'restart'
    end
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      within release_path do
        execute :rake, 'tmp:cache:clear'
      end
    end
  end
end
