RSpec.describe Ember::CLI::Deploy::Rack::Engine do
  context 'debug is enabled' do
    describe '/debug' do
      it 'renders debug information' do
        app.settings.debug = true

        get '/debug'

        expect(last_response).to be_ok
      end
    end
  end

  context 'debug is disabled' do
    describe '/debug' do
      it 'response with 403' do
        app.settings.debug = false

        get '/debug'

        expect(last_response.status).to eq 403
      end
    end
  end
end