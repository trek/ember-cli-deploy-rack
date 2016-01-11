#!/usr/bin/env rackup

# This file is used by Rack-based servers to start the application.

require 'bundler/setup'

require 'ember/cli/deploy/rack'

engine = Ember::CLI::Deploy::Rack::Engine.new

# === Settings ====

# engine.settings.set :root, Dir.pwd
# engine.settings.set :key_prefix, 'ember-cli-deploy-rack:index'
# engine.settings.set :active_content_suffix, 'current-content'
# engine.settings.set :revision, { regexp: '^[0-9a-f]{32}$' }
# engine.settings.set :redis, { host: '127.0.0.1', ... }
# engine.settings.set :redis_client, proc { Redis.new settings.redis }
# engine.settings.set :debug, false

# === Logging ====

# log_dir = File.expand_path 'log'
#
# if File.directory? log_dir
#   log_file = File.expand_path "#{engine.settings.environment}.log", log_dir
#
#   logger = Logger.new log_file, File::WRONLY | File::APPEND | File::CREAT
#   logger.level = Logger::DEBUG
#
#   engine.settings.set :logger, logger
# end

run engine