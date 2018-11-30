# frozen_string_literal: true

require 'rails_helper'

RSpec.describe API::V1::Auth::Refresh do
  include Rack::Test::Methods

  def app
    API::V1::Auth::Refresh
  end

  describe 'POST /api/v1/auth/refresh' do
    before do
      create(
        :access_token,
        essence_hash: Digest::SHA2.hexdigest('valid_essence'),
        refresh_token_hash: Digest::SHA2.hexdigest('valid_refresh_token'),
        expires_at: 1.hour.since
      )
    end

    context 'valid' do
      let(:params) { { refresh_token: 'valid_refresh_token' } }

      it 'returns code 201' do
        header 'X-Auth-Token', 'valid_essence'
        post '/api/v1/auth/refresh', params

        expect(last_response.status).to eq(201)
      end
    end

    context 'fail' do
      let(:params) { { refresh_token: 'wrong_refresh_token' } }

      it 'with wrong X-Auth-Token returns code 403' do
        header 'X-Auth-Token', 'wrong_essence'
        post '/api/v1/auth/refresh', params

        expect(last_response.status).to eq(403)
      end

      it 'with wrong refresh token returns code 403' do
        header 'X-Auth-Token', 'valid_essence'
        post '/api/v1/auth/refresh', params

        expect(last_response.status).to eq(403)
      end
    end
  end
end
