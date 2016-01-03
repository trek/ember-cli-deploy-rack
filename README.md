[Ember CLI Deploy Rack]
=======================

[![Travis CI Status][Travis CI Status]][Travis CI]
[![Code Climate Status][Code Climate Status]][Code Climate]
[![Test Coverage Status][Test Coverage Status]][Test Coverage]
[![Gemnasium Status][Gemnasium Status]][Gemnasium]

**A [Rack] package to launch your [Ember.js] application into the Cloud.**

Summary
-------

Ember CLI Deploy Rack can be used to serve an [Ember CLI] application deployed with the help of [Ember CLI Deploy] and
[ember-deploy-redis]. Basically, it is ready to use Sinatra application, which connects to Redis and returns the
uploaded index.html.

Basically, it is a [Sinatra] application, which connects to Redis and returns the uploaded index.html.

Basically, it is a [Sinatra] application, which connects to Redis and returns the uploaded index.html.

You can deploy your application to production, test it out by passing an `revision` parameter with the revision you want
to test and activate when you feel confident that everything is working as expected.

For further information see [Ember CLI Deploy].

Prerequisites
-------------

* [Ruby]
* [Redis]

Installation
------------

1. Create a Gemfile

    ```ruby
    #!/usr/bin/env bundle

    source 'https://rubygems.org'

    gem 'ember-cli-deploy-rack', github: 'bitaculous/ember-cli-deploy-rack', require: false
    ```

2. Run `bundle` to install all dependencies with [Bundler]

Usage
-----

1. Create a Rack configuration

    ```ruby
    #!/usr/bin/env rackup

    # This file is used by Rack-based servers to start the application.

    require 'bundler/setup'

    require 'ember/cli/deploy/rack'

    engine = Ember::CLI::Deploy::Rack::Engine.new
    engine.settings.set :root, Dir.pwd

    run engine
    ```

2. Run the engine with `rackup` or your favorite Ruby Webserver

Configuration
-------------

Ember CLI Deploy Rack can be configured in various ways:

1. Via settings

    ```ruby
    engine = Ember::CLI::Deploy::Rack::Engine.new
    engine.settings.set :root, Dir.pwd
    # engine.settings.set :index_id, 'ember-cli-deploy-rack'
    # engine.settings.set :redis_client, proc { Redis.new redis_client_configuration }
    # engine.settings.set :redis_client_configuration, { host: '127.0.0.1', ... }

    run engine
    ```

2. Via YAML configuration files

    Just create a configuration file `config/settings.yml` and adjust properly, for an example see
    [resources/config/settings.yml]. You can also create environment specific configurations under
    `config/settings/{ENVIRONMENT}.yml`.

Development
-----------

### Run specs with [RSpec]

Run `rspec`.

or via [Guard]:

```
$ guard -g spec
```

### See Test Coverage

Run `COVERAGE=true rspec`.

### Run [RuboCop]

Run `rubocop`.

To run all specs and RuboCop altogether, run `rake`.

Bug Reports
-----------

Github Issues are used for managing bug reports and feature requests. If you run into issues, please search the issues
and submit new problems [here].

Versioning
----------

This library aims to adhere to [Semantic Versioning 2.0.0]. Violations of this scheme should be reported as bugs.
Specifically, if a minor or patch version is released that breaks backward compatibility, that version should be
immediately yanked and / or a new version should be immediately released that restores compatibility.

License
-------

Ember CLI Deploy Rack is released under the [MIT License (MIT)], see [LICENSE].

[Bundler]: http://bundler.io "The best way to manage a Ruby application's gems"
[Code Climate]: https://codeclimate.com/github/bitaculous/ember-cli-deploy-rack "Ember CLI Deploy Rack at Code Climate"
[Code Climate Status]: https://img.shields.io/codeclimate/github/bitaculous/ember-cli-deploy-rack.svg?style=flat "Code Climate Status"
[Ember CLI]: http://www.ember-cli.com "The command line interface for ambitious web applications."
[Ember CLI Deploy Rack]: https://bitaculous.github.io/ember-cli-deploy-rack/ "A Rack package to launch your Ember.js application into the Cloud."
[Ember CLI Deploy]: http://ember-cli.github.io/ember-cli-deploy "Simple, flexible deployment for your Ember app"
[ember-deploy-redis]: https://github.com/ember-cli-deploy/ember-cli-deploy-redis "An ember-cli-deploy plugin to upload index.html to a Redis store."
[Ember.js]: http://emberjs.com "A framework for creating ambitious web applications."
[Foreman]: http://ddollar.github.io/foreman "Manage Procfile-based applications"
[Gemnasium]: https://gemnasium.com/bitaculous/ember-cli-deploy-rack "Ember CLI Deploy Rack at Gemnasium"
[Gemnasium Status]: https://img.shields.io/gemnasium/bitaculous/ember-cli-deploy-rack.svg?style=flat "Gemnasium Status"
[Guard]: http://guardgem.org "A command line tool to easily handle events on file system modifications."
[here]: https://github.com/bitaculous/ember-cli-deploy-rack/issues "Github Issues"
[LICENSE]: https://raw.githubusercontent.com/bitaculous/ember-cli-deploy-rack/master/LICENSE "License"
[MIT License (MIT)]: http://opensource.org/licenses/MIT "The MIT License (MIT)"
[Rack]: http://rack.github.io "A Ruby Webserver Interface"
[Redis]: http://redis.io "An open source, BSD licensed, advanced key-value cache and store."
[resources/config/settings.yml]: https://github.com/bitaculous/ember-cli-deploy-rack/blob/master/resources/config/settings.yml "Sample YAML configuration"
[RSpec]: http://rspec.info "Behaviour Driven Development for Ruby"
[RuboCop]: https://github.com/bbatsov/rubocop "A Ruby static code analyzer, based on the community Ruby style guide."
[Ruby]: https://www.ruby-lang.org "A dynamic, open source programming language with a focus on simplicity and productivity."
[Semantic Versioning 2.0.0]: http://semver.org "Semantic Versioning 2.0.0"
[Sinatra]: http://www.sinatrarb.com "A DSL for quickly creating web applications in Ruby with minimal effort."
[Test Coverage]: https://codeclimate.com/github/bitaculous/ember-cli-deploy-rack "Test Coverage (Code Climate)"
[Test Coverage Status]: https://img.shields.io/codeclimate/coverage/github/bitaculous/ember-cli-deploy-rack.svg?style=flat "Test Coverage Status"
[Travis CI]: https://travis-ci.org/bitaculous/ember-cli-deploy-rack "Ember CLI Deploy Rack at Travis CI"
[Travis CI Status]: https://img.shields.io/travis/bitaculous/ember-cli-deploy-rack.svg?style=flat "Travis CI Status"