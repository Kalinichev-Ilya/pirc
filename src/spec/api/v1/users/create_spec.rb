# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::Users::Create do
  include Rack::Test::Methods

  def app
    V1::Users::Create
  end

  context 'POST /api/v1/users' do
    let(:params) { attributes_for(:user) }

    it 'returns code 201' do
      post '/api/v1/users', params

      expect(last_response.status).to eq(201)
    end
  end
end
