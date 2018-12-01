# frozen_string_literal: true

module API
  module V1
    module Channels
      class Create < Grape::API
        before do
          authenticate!
        end

        helpers do
          def owner
            User.find_by!(id: declared(params)[:owner_id])
          end
        end

        version :v1 do
          # POST /api/v1/channel
          desc 'Create channel',
            named: 'create new channel',
            success: { code: 201, model: API::V1::Entities::Channel },
            failure: [
              { code: 401, model: API::Errors::UnauthorizedError },
              { code: 401, model: API::Errors::UnexpectedError },
              { code: 401, model: API::Errors::ChannelAlreadyExistError }
            ]
          params do
            requires :owner_id, type: String
            requires :channel_name, type: String
          end
          post do
            result = Operations::Channel::Create.new(owner, params[:channel_name]).call
            error! authenticator_error(result.error), 401 if result.failure?
            present result.channel, with: API::V1::Entities::Channel
          end
        end
      end
    end
  end
end
