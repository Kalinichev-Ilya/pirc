# frozen_string_literal: true

require 'rails_helper'

RSpec.describe API::V1::Errors, type: :request do
  it 'returns Errors::NotFound status 404' do
    get '/api/v1/whatever'

    expect(response.status).to eq(404)
  end
end
