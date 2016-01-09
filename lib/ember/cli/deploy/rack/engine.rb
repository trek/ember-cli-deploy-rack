require 'logger'
require 'redis'
require 'sinatra/base'
require 'sinatra/config_file'
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

          ROOT                  = File.expand_path '../../../../../../', __FILE__
          VIEWS                 = File.expand_path 'views', ROOT
          CONFIG                = 'config/settings.yml'

          KEY_PREFIX            = 'ember-cli-deploy-rack:index'
          ACTIVE_CONTENT_SUFFIX = 'current-content'
          REVISION_REGEXP       = '^[0-9a-f]{32}$'

          # === Extensions ===

          register Sinatra::ConfigFile

          # === Settings ===

          set :root, ROOT

          set :views, VIEWS

          set :key_prefix, KEY_PREFIX

          set :active_content_suffix, ACTIVE_CONTENT_SUFFIX

          set :revision, 'regexp' => REVISION_REGEXP

          set :redis, proc {
            defaults = Redis::Client::DEFAULTS.dup

            defaults.keys.each do |key|
              # Fill in defaults if needed
              defaults[key] = defaults[key].call if defaults[key].respond_to? :call
            end

            defaults
          }

          set :redis_client, proc {
            Redis.new settings.redis
          }

          set :debug, false

          set :version, Ember::CLI::Deploy::Rack::VERSION

          # === Extensions ===

          config_file File.expand_path CONFIG

          # === Helpers ===

          helpers Sinatra::CustomLogger

          # === Configuration ===

          configure do
            logfile = File.open "#{settings.root}/log/#{environment}.log", 'a'
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

          get '/debug' do
            if settings.debug
              @id    = 'debug'
              @title = 'Debug'

              haml :debug
            else
              halt 403
            end
          end

          # === Private ===

          protected

          def index(revision)
            key = get_key revision

            logger.debug "Getting content from Redis with key: `#{key}`..."

            redis_client = settings.redis_client

            redis_client.get(key) || halt(404)
          end

          def get_key(revision)
            key = "#{settings.key_prefix}:#{settings.active_content_suffix}"

            if revision
              regexp = Regexp.new settings.revision['regexp'], 1

              if revision =~ regexp
                key = "#{settings.key_prefix}:#{revision}"
              else
                halt 400
              end
            end

            key
          end
        end
      end
    end
  end
end