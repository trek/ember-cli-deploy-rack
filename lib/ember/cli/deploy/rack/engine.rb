require 'config'
require 'config/integration/sinatra'
require 'logger'
require 'redis'
require 'sinatra/base'
require 'sinatra/custom_logger'
require 'sinatra/reloader'

module Ember
  module CLI
    module Deploy
      module Rack # :nodoc:
        # = Engine
        #
        # The engine class of `Ember::CLI::Deploy::Rack`, inherited from `Sinatra::Application`.
        class Engine < Sinatra::Application
          # === Settings ===

          set :root, File.expand_path('../../../../../../', __FILE__)

          set :key_prefix, proc {
            key_prefix = Settings.key_prefix ? Settings.key_prefix : 'ember-cli-deploy-rack:index'

            key_prefix.downcase
          }

          set :active_content_suffix, proc {
            active_content_suffix = Settings.active_content_suffix ? Settings.active_content_suffix : 'current-content'

            active_content_suffix.downcase
          }

          set :revision_regexp, proc {
            regexp = /^[0-9a-f]{32}$/i

            if Settings.revision && Settings.revision.regexp
              regexp = Regexp.new Settings.revision.regexp, 1
            end

            regexp
          }

          set :redis_client, proc {
            Redis.new redis_client_configuration
          }

          set :redis_client_configuration, proc {
            defaults = Redis::Client::DEFAULTS.dup

            defaults.keys.each do |key|
              # Fill in defaults if needed
              defaults[key] = defaults[key].call if defaults[key].respond_to? :call
            end

            settings = Settings.redis ? Settings.redis.to_h : {}

            defaults.merge settings
          }

          set :version, Ember::CLI::Deploy::Rack::VERSION

          # === Extensions ===

          register Config

          # === Helpers ===

          helpers Sinatra::CustomLogger

          # === Configuration ===

          configure do
            logfile = File.open "#{root}/log/#{environment}.log", 'a'
            logger  = Logger.new logfile

            logger.level = Logger::DEBUG if development?

            set :logger, logger
          end

          configure :development do
            register Sinatra::Reloader
          end

          # === Routes ===

          get '/' do
            content_type 'text/html'

            logger.debug 'Processing request for `/` route...'

            index params[:revision]
          end

          # === Private ===

          protected

          def index(revision)
            key = get_key revision

            logger.debug "Getting content from Redis with key: `#{key}`..."

            redis = settings.redis_client

            redis.get(key) || halt(404)
          end

          def get_key(revision)
            key = "#{settings.key_prefix}:#{settings.active_content_suffix}"
            key = "#{settings.key_prefix}:#{revision}" if revision && revision =~ settings.revision_regexp

            key
          end
        end
      end
    end
  end
end