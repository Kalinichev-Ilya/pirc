# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AccessToken do
  let(:token) { build(:token) }

  it 'instance return valid true' do
    expect(token.valid?).to be_truthy
  end

  let(:user) { build(:user) }
  let(:device_params) { { ip: Faker::Internet.ip_v4_address, fingerprint: rand(10000..999999) } }

  it 'success generate', focus: true do
    expect(AccessToken.generate!(user, device_params)).to be_a(AccessToken)
  end
end
