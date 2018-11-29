# frozen_string_literal: true

require 'rails_helper'

RSpec.describe API::V1::Auth::Create do
  include Rack::Test::Methods

  def app
    API::V1::Auth::Create
  end

  describe 'POST /api/v1/auth' do
    let(:user) { create(:user) }
    let(:device_params) { { device: { fingerprint: 'whatever' } } }
    let(:params) { sign_in_params.merge!(device_params) }

    context 'valid' do
      let(:sign_in_params) { { username: user.username, password: user.password } }

      it 'returns code 201' do
        post '/api/v1/auth', params

        expect(last_response.status).to eq(201)
      end
    end

    context 'failure' do
      let(:sign_in_params) { { username: user.username, password: 'wH4t3ver!' } }

      context 'with wrong password' do
        it 'get 401 for :invalid_email_or_password error' do
          post '/api/v1/auth', params

          expect(last_response.status).to eq(401)
        end
      end
    end
  end
end
