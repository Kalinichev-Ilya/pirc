# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AccessToken do
  context '#create' do
    let(:access_token) { build(:access_token) }

    it 'success' do
      expect(access_token).to be_valid
    end
  end

  context '.find_through_encode' do
    let(:access_token) {
      create(
        :access_token,
        essence_hash: '092bd8646cf5c6a62b659c0c895b86dfa5a692ee0e2e51257a7cf47b3a2fd1f2', # sha2 from 'essence'
        refresh_token_hash: '6c8a7d4aa21708a432174e4cb5c6cfaf0218f5f3e52f9a76a7d95d2aaade2c83' # sha2 from 'refresh_token'
      )
    }
    let(:essence) { 'essence' }
    let(:refresh_token) { 'refresh_token' }

    it 'successful find' do
      access_token
      expect(described_class.find_through_encode(essence)).to be_instance_of(described_class)
    end
  end

  context '#valid_refresh_token?' do
    let(:refresh_token_hash) { Digest::SHA2.hexdigest('whatever') }
    let(:access_token) { create(:access_token, refresh_token_hash: refresh_token_hash) }

    it 'returns true' do
      expect(access_token).to be_valid_refresh_token('whatever')
    end

    it 'return false' do
      expect(access_token).not_to be_valid_refresh_token('different sorts of things')
    end
  end

  context '#refresh!' do
    let(:time_current) { Time.current }
    let(:access_token) { create(:access_token, expires_at: time_current) }
    let(:expected_time) { time_current + 1.hour }

    it 'success refresh expires_at' do
      access_token.refresh!
      expect(access_token.expires_at.to_i).to eq(expected_time.to_i)
    end
  end

  context '#active?' do
    let(:access_token) { create(:access_token) }

    it 'returns true' do
      expect(access_token).to be_active
    end

    it 'returns false' do
      access_token.update!(expires_at: 1.hour.ago)
      expect(access_token).not_to be_active
    end
  end
end
