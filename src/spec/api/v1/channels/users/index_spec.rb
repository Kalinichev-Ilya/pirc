# frozen_string_literal: true

require 'rails_helper'

RSpec.describe API::V1::Channels::Users::Index do
  include Rack::Test::Methods

  def app
    API::V1::Channels::Users::Index
  end

  describe 'GET /api/v1/channels/:id/users' do
    let(:essence) { Faker::RickAndMorty.quote }
    let(:refresh_token) { Faker::RickAndMorty.quote }
    let(:essence_hash) { Digest::SHA2.hexdigest(essence) }
    let(:refresh_token_hash) { Digest::SHA2.hexdigest(refresh_token) }

    let(:access_token) do
      create(
        :access_token,
        essence_hash: essence_hash,
        refresh_token_hash: refresh_token_hash
      )
    end

    let(:owner) { create(:user, access_tokens: [access_token]) }
    let(:channel) { create(:channel, owner_id: owner.id) }

    let(:user) { create(:user) }
    let(:membership) { create(:membership, user_id: user.id, channel_id: channel.id) }

    context 'valid' do
      it 'returns code 201' do
        membership

        header 'X-Auth-Token', essence
        get "/api/v1/channel/#{channel.id}/users"

        expect(last_response.status).to eq(200)
      end
    end

    context 'failure' do
      let(:channel_id) { 'whatever' }

      it 'with wrong channel_id returns NotFound' do
        membership

        header 'X-Auth-Token', essence
        get "/api/v1/channel/#{channel_id}/users"

        expect(last_response.status).to eq(404)
      end
    end
  end
end
