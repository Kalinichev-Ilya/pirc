# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Operations::Auth::Validate do
  let(:user) { create(:user) }

  let(:request_params) {
    {
      username: user.username,
      password: user.password,
      device: {
        ip: Faker::Internet.ip_v4_address,
        fingerprint: rand(10000..999999)
      }
    }
  }

  it 'valid session returns true' do
    expect(described_class.new(*request_params).call).to be_truthy
  end
end
