#!/usr/bin/env rackup

# This file is used by Rack-based servers to start the application.

require 'bundler/setup'

require 'ember/cli/deploy/rack'

engine = Ember::CLI::Deploy::Rack::Engine.new
# engine.settings.set :root, Dir.pwd
# engine.settings.set :key_prefix, 'ember-cli-deploy-rack:index'
# engine.settings.set :redis_client, proc { Redis.new redis_client_configuration }
# engine.settings.set :redis_client_configuration, { host: '127.0.0.1' }

run engine