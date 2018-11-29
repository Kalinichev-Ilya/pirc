# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Operations::Auth::Validate do
  let(:user) { create(:user) }

  context 'user with wrong password' do
    let(:request_params) {
      {
        username: user.username,
        password: 'whatever',
        device: {
          ip: 'whatever',
          fingerprint: 'whatever'
        }
      }
    }

    it 'returns failure :invalid_email_or_password' do
      expect(described_class.new(**request_params).call.error).to eq(:invalid_email_or_password)
    end
  end

  context 'user with valid password' do
    let(:request_params) {
      {
        username: user.username,
        password: user.password,
        device: {
          ip: 'whatever',
          fingerprint: 'whatever'
        }
      }
    }

    it 'success verified' do
      expect(described_class.new(**request_params).call.user).to be_instance_of(User)
    end
  end
end
