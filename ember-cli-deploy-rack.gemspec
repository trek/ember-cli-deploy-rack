#!/usr/bin/env gem build

require_relative 'lib/ember/cli/deploy/rack/version'

Gem::Specification.new 'ember-cli-deploy-rack', Ember::CLI::Deploy::Rack::VERSION do |spec|
  spec.summary          = 'A Rack package to launch your Ember.js application into the Cloud.'
  spec.author           = 'Maik Kempe'
  spec.email            = 'mkempe@bitaculous.com'
  spec.homepage         = 'https://bitaculous.github.io/ember-cli-deploy-rack/'
  spec.license          = 'MIT'
  spec.files            = Dir['{lib,resources,spec}/**/*', 'CHANGELOG.md', 'CONTRIBUTING.md', 'LICENSE', 'README.md']
  spec.extra_rdoc_files = ['CHANGELOG.md', 'CONTRIBUTING.md', 'LICENSE', 'README.md']
  spec.metadata         = {
    source_code:   'https://github.com/bitaculous/ember-cli-deploy-rack',
    issue_tracker: 'https://github.com/bitaculous/ember-cli-deploy-rack/issues'
  }

  spec.required_ruby_version     = '~> 2.2'
  spec.required_rubygems_version = '~> 2.4'

  spec.add_runtime_dependency 'sinatra',         '~> 1.4', '>= 1.4.7'
  spec.add_runtime_dependency 'sinatra-contrib', '~> 1.4', '>= 1.4.6'
  spec.add_runtime_dependency 'haml',            '~> 4.0', '>= 4.0.7'
  spec.add_runtime_dependency 'redis',           '~> 3.2', '>= 3.2.2'

  spec.add_development_dependency 'rake',  '~> 10.5', '>= 10.5.0'
  spec.add_development_dependency 'rspec', '~> 3.4',  '>= 3.4.0'
end