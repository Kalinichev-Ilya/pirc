# frozen_string_literal: true

require 'rails_helper'

RSpec.describe API::V1::Users::Create do
  include Rack::Test::Methods

  def app
    API::V1::Users::Create
  end

  describe 'POST /api/v1/users' do
    context 'valid' do
      let(:params) { attributes_for(:user) }

      it 'returns code 201' do
        binding.pry
        post '/api/v1/users', params

        expect(last_response.status).to eq(201)
      end
    end

    context 'failure' do
      let(:params) { attributes_for(:user, :invalid) }

      it 'returns validation error status 422' do
        post '/api/v1/users', params

        expect(last_response.status).to eq(422)
      end
    end
  end
end
