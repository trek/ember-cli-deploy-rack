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
          # === Constants ===

          REVISION = /\A[0-9a-f]{7}\z/i

          # === Settings ===

          set :root, File.expand_path('../../../../../../', __FILE__)

          set :index_id, proc {
            index_id = Settings.index_id ? Settings.index_id : 'ember-cli-deploy-rack'

            index_id.downcase
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
            if revision && revision =~ REVISION
              index_key = "#{settings.index_id}:#{revision}"
            else
              index_key = "#{settings.index_id}:current"
            end

            logger.debug "Getting content from Redis with index key: `#{index_key}`..."

            redis = settings.redis_client

            redis.get(index_key) || halt(404)
          end
        end
      end
    end
  end
end