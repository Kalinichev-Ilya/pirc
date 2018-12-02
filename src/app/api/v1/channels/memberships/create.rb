# frozen_string_literal: true

module API
  module V1
    module Channels
      module Memberships
        class Create < Grape::API
          before do
            authenticate!
          end

          version :v1 do
            # POST /api/v1/channel/:channel_id/membership
            desc 'Invite user in channel',
              named: 'add user to channel',
              success: { code: 201, model: API::V1::Entities::Channel },
              failure: [
                { code: 401, model: API::Errors::UnauthorizedError },
                { code: 401, model: API::Errors::UnexpectedError },
                { code: 401, model: API::Errors::MemberExistError }
              ]
            params do
              requires :user_id, type: String
            end

            post do
              result = Operations::Membership::Create.new(channel, user).call
              error! authenticator_error(result.error), 401 if result.failure?
              present result.channel, with: API::V1::Entities::Channel
            end
          end
        end
      end
    end
  end
end
