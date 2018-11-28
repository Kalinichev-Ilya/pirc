# frozen_string_literal: true

require 'rails_helper'

RSpec.describe API::V1::Auth::Create do
  include Rack::Test::Methods

  def app
    API::V1::Auth::Create
  end

  describe 'POST /api/v1/auth' do
    let(:device_params) { { device: { fingerprint: 12345 } } }

    context 'valid' do
      let(:user) { create(:user, :signed) }
      let(:sign_in_params) { { username: user.username, password: user.password } }
      let(:params) { sign_in_params.merge!(device_params) }

      it 'returns code 201' do
        post '/api/v1/auth', params

        expect(last_response.status).to eq(201)
      end
    end

    context 'failure' do
      let(:access_token) { create(:access_token, :expired) }
      let(:user) { create(:user, access_token: access_token) }
      let(:sign_in_params) { { username: user.username, password: user.password } }
      let(:params) { sign_in_params.merge!(device_params) }

      it 'get 401 for :device_verification_needed error' do
        post '/api/v1/auth', params

        expect(last_response.status).to eq(401)
      end

      context 'with wrong password' do
        let(:sign_in_params) { { username: user.username, password: 'wH4t3ver!' } }

        it 'get 401 for :invalid_email_or_password error' do
          post '/api/v1/auth', params

          expect(last_response.status).to eq(401)
        end
      end
    end
  end
end
