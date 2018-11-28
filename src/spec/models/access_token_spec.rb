# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AccessToken do
  let(:access_token) { build(:access_token) }

  let(:device_params) { { ip: Faker::Internet.ip_v4_address, fingerprint: rand(10000..999999) } }
  let(:user) { build(:user) }

  it 'instance return valid true' do
    expect(access_token).to be_valid
  end

  it 'success generate' do
    expect(described_class.generate!(user, device_params)).to be_a(described_class)
  end
end
