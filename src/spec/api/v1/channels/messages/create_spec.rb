# frozen_string_literal: true

require 'rails_helper'

RSpec.describe API::V1::Channels::Messages::Create do
  include Rack::Test::Methods

  def app
    API::V1::Channels::Messages::Create
  end

  describe 'POST /api/v1/channel/:id/message' do
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

    let(:params) do
      {
        user_id: user.id,
        channel_id: channel.id,
        message_type: 'plain',
        text: Faker::RickAndMorty.quote
      }
    end

    context 'valid' do
      it 'returns code 201' do
        membership

        header 'X-Auth-Token', essence
        post "/api/v1/channel/#{channel.id}/message", params

        expect(last_response.status).to eq(201)
      end
    end

    context 'failure' do
      let(:membership) { create(:membership, channel_id: channel.id) }

      it 'returns UserNotAMemberError' do
        membership

        header 'X-Auth-Token', essence
        post "/api/v1/channel/#{channel.id}/message", params

        expect(last_response.status).to eq(401)
      end
    end
  end
end
