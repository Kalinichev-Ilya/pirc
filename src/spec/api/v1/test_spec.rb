require 'rails_helper'

RSpec.describe V1::Test do
  include Rack::Test::Methods

  def app
    V1::Test
  end

  context 'GET /api/v1/test' do
    it 'returns code 200' do
      get '/api/v1/test'

      expect(last_response.status).to eq(200)
    end
  end
end
