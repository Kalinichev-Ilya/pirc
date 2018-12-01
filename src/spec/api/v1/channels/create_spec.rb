# frozen_string_literal: true

require 'rails_helper'

RSpec.describe API::V1::Channels::Create do
  include Rack::Test::Methods

  def app
    API::V1::Channels::Create
  end

  describe 'POST /api/v1/channel' do
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
    let(:params) {
      { owner_id: owner.id,
        channel_name: 'whatever' }
    }

    context 'valid' do
      it 'returns code 201' do
        header 'X-Auth-Token', essence
        post '/api/v1/channel', params

        expect(last_response.status).to eq(201)
      end
    end

    context 'failure' do
      let(:channel_name) { Faker::RickAndMorty.character }
      let(:exist_channel) { create(:channel, name: channel_name) }
      let(:params) {
        { owner_id: owner.id,
          channel_name: channel_name }
      }

      it 'returns ChannelAlreadyExistError' do
        exist_channel

        header 'X-Auth-Token', essence
        post '/api/v1/channel', params

        expect(last_response.status).to eq(401)
      end
    end
  end
end
