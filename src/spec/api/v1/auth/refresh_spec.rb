# frozen_string_literal: true

require 'rails_helper'

RSpec.describe API::V1::Auth::Refresh do
  include Rack::Test::Methods

  def app
    API::V1::Auth::Refresh
  end

  describe 'POST /api/v1/auth/refresh' do
    let(:access_token) { create(:access_token) }
    let(:params) { { refresh_token: 'valid_refresh_token' } }

    context 'valid' do
      it 'returns code 201' do
        header 'X-Auth-Token', 'valid_essence'
        post '/api/v1/auth/refresh', params

        expect(last_response.status).to eq(201)
      end
    end
  end
end
