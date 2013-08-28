require "rvm/capistrano"
set :rvm_ruby_string, "ruby-1.9.3"

set :application, "smartbars"
set :rails_env, "production" #added for delayed job

# SSH credentials
set :domain, "46.16.234.176"
set :user, "deploy"
ssh_options[:forward_agent] = true

# roles
role :web, domain
role :app, domain
role :db,  domain, primary: true

# version control
set :repository,  "git@github.com:<USER>/#{application}.git"
set :scm, :git
set :scm_username, "<USER>"
set :scm_password, "<PASSWORD>"
set :branch, "master"

# extensions
$LOAD_PATH.unshift File.join(File.dirname(__FILE__), 'deploy')
require 'bundler/capistrano'
require 'delayed/recipes'
set :template_dir, 'gitignore'
require 'capistrano_database_yml'
load 'deploy/assets'

# deployment
set :deploy_to, "/var/www/#{application}"
set :deploy_via, :remote_cache
set :chmod755, "app config db lib public vendor script script/* public/disp*"

# delayed jobs
set :delayed_job_server_role, :app
after "deploy:stop",    "delayed_job:stop"
after "deploy:start",   "delayed_job:start"
after "deploy:restart", "delayed_job:restart"

# additional settings and actions
default_run_options[:pty] = true
after "deploy:restart", "deploy:cleanup"

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

