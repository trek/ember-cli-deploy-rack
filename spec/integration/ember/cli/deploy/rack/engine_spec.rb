RSpec.describe Ember::CLI::Deploy::Rack::Engine do
  let(:index_id) { app.settings.index_id }
  let(:redis)    { app.settings.redis_client }

  context 'data available' do
    describe '/' do
      it 'returns the current revision as default' do
        revision = 'current'
        fixture  = File.expand_path "ember/cli/deploy/rack/engine/revisions/#{revision}.html", fixtures
        html     = IO.read fixture

        redis.set "#{index_id}:#{revision}", html

        get '/'

        expect(last_response).to be_ok
        expect(last_response.body).to eq html
      end

      it 'returns a specific revision' do
        revision = 'be526e6'
        fixture  = File.expand_path "ember/cli/deploy/rack/engine/revisions/#{revision}.html", fixtures
        html     = IO.read fixture

        redis.set "#{index_id}:#{revision}", html

        get '/', revision: revision

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