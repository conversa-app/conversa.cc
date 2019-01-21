# frozen_string_literal: true

set :deploy_to, '/var/www/conversa_production'
set :user, 'deploy'
set :branch, 'master'
set :ssh_options, forward_agent: true

# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary
# server in each group is considered to be the first
# unless any hosts have the primary property set.
role :app, %w[deploy@45.56.108.166]
role :web, %w[deploy@45.56.108.166]
role :db,  %w[deploy@45.56.108.166]