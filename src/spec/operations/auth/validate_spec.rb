# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Operations::Auth::Validate do
  context 'user with active session' do
    let(:user) { create(:user, :signed) }

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

    it 'success verified' do
      expect(described_class.new(**request_params).call).to be_truthy
    end
  end

  context 'user with wrong password' do
    let(:user) { create(:user) }

    let(:request_params) {
      {
          username: user.username,
          password: 'whatever',
          device: {
              ip: Faker::Internet.ip_v4_address,
              fingerprint: rand(10000..999999)
          }
      }
    }

    it 'returns failure :invalid_email_or_password' do
      expect(described_class.new(**request_params).call).to include(:invalid_email_or_password)
    end
  end

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
      expect(described_class.new(**request_params).call).to include(:device_verification_needed)
    end
  end
end
