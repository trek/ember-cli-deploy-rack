RSpec.describe Ember::CLI::Deploy::Rack::Engine do
  let(:key_prefix) { app.settings.key_prefix }
  let(:redis)      { app.settings.redis_client }

  it 'response with 400 when revision is not valid' do
    revision = 'invalid-revision'

    get '/', revision: revision

    expect(last_response.status).to eq 400
  end

  context 'data available' do
    describe '/*' do
      it 'returns the `current-content` revision as default' do
        revision = 'current-content'
        fixture  = File.expand_path "ember/cli/deploy/rack/engine/revisions/#{revision}.html", fixtures
        html     = IO.read fixture

        redis.set "#{key_prefix}:#{revision}", html

        get '/'

        expect(last_response).to be_ok
        expect(last_response.body).to eq html

        get '/foo/bar'

        expect(last_response).to be_ok
        expect(last_response.body).to eq html
      end

      it 'returns a specific revision' do
        revision = 'e56b0f2850be071697ab61c41ce8f3c0'
        fixture  = File.expand_path "ember/cli/deploy/rack/engine/revisions/#{revision}.html", fixtures
        html     = IO.read fixture

        redis.set "#{key_prefix}:#{revision}", html

        get '/', revision: revision

        expect(last_response).to be_ok
        expect(last_response.body).to eq html

        get '/foo/bar', revision: revision

        expect(last_response).to be_ok
        expect(last_response.body).to eq html
      end
    end
  end

  context 'no data available' do
    describe '/' do
      it 'response with 404' do
        get '/'

        expect(last_response.status).to eq 404
      end
    end
  end
end