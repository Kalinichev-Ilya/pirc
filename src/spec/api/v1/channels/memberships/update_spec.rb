# frozen_string_literal: true

require 'rails_helper'

RSpec.describe API::V1::Channels::Memberships::Update do
  include Rack::Test::Methods

  def app
    API::V1::Channels::Memberships::Update
  end

  describe 'PATCH /api/v1/channel/:id/membership' do
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

    let(:owner) { create(:user) }
    let(:channel) { create(:channel, owner_id: owner.id) }

    let(:user) { create(:user, access_tokens: [access_token]) }
    let(:membership) { create(:membership, user_id: user.id, channel_id: channel.id, is_favorite: false) }
    let(:params) { { is_favorite: true } }

    context 'valid' do
      it 'returns code 201' do
        membership

        header 'X-Auth-Token', essence
        patch "/api/v1/channel/#{channel.id}/membership", params

        expect(last_response.status).to eq(200)
      end
    end

    context 'failure' do
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

      let(:user_without_membership) { create(:user, access_tokens: [access_token]) }

      it 'returns NotFound if user not a member' do
        user_without_membership

        header 'X-Auth-Token', essence
        patch "/api/v1/channel/#{channel.id}/membership", params

        expect(last_response.status).to eq(404)
      end
    end
  end
end
