# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Operations::Auth::Validate do
  context 'user first login' do
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

    it 'returns failure :device_verification_needed' do
      expect(described_class.new(**request_params).call.error).to eq(:device_verification_needed)
    end
  end

  context 'user with wrong password' do
    let(:user) { create(:user, :signed) }
    let(:request_params) {
      {
        username: user.username,
        password: 'whatever',
        device: {
          ip: user.access_token.ip,
          fingerprint: '12345'
        }
      }
    }

    it 'returns failure :invalid_email_or_password' do
      expect(described_class.new(**request_params).call.error).to eq(:invalid_email_or_password)
    end
  end

  context 'user with valid session' do
    let(:user) { create(:user, :signed) }
    let(:request_params) {
      {
        username: user.username,
        password: user.password,
        device: {
          ip: user.access_token.ip,
          fingerprint: '12345'
        }
      }
    }

    it 'success verified' do
      expect(described_class.new(**request_params).call.user).to be_instance_of(User)
    end
  end
end
