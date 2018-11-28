# frozen_string_literal: true

require 'rails_helper'

RSpec.describe API::V1::Users::Create do
  include Rack::Test::Methods

  def app
    API::V1::Users::Create
  end

  describe 'POST /api/v1/users' do
    context 'valid' do
      let(:user) { build(:user) }
      let(:params) {
        { username: user.username,
          password: user.password,
          password_confirmation: user.password }
      }

      it 'returns code 201' do
        post '/api/v1/users', params

        expect(last_response.status).to eq(201)
      end
    end

    context 'failure' do
      let(:params) { attributes_for(:user, :dummy) }

      it 'returns validation error status 400' do
        post '/api/v1/users', params

        expect(last_response.status).to eq(400) # TODO: add error handling, 401
      end
    end
  end
end
