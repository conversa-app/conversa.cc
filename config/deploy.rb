# frozen_string_literal: true

# config valid for current version and patch releases of Capistrano
lock '~> 3.11.0'

set :application, 'conversa'
set :repo_url, 'git@github.com:conversa-app/conversa.cc.git'
set :init_system, :systemd

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

set :linked_files, %w[config/database.yml config/master.key]
set :linked_dirs, %w[
  storage
  log tmp/pids tmp/cache
  tmp/sockets vendor/bundle
  public/images public/system
  node_modules
]
set :bundle_binstubs, nil
# set :default_env, { path: "/opt/ruby/bin:$PATH" }
set :keep_releases, 5

namespace :app do
  desc 'Restart Puma'
  task :restart do
    on roles(:web) do |_host|
      within release_path do
        execute :sudo, :monit, :restart, 'sidekiq'
        execute :sudo, :systemctl, :restart, 'puma.service'
      end
    end
  end
end