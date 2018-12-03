# frozen_string_literal: true

module API
  module V1
    module Channels
      module Messages
        class Create < Grape::API
          before do
            authenticate!
          end

          helpers do
            def channel
              Channel.find_by!(owner: current_user, id: params[:id])
            end

            def user
              User.find(declared(params)[:user_id])
            end

            def message_params
              Hash.new({}).tap do |p|
                p[:channel] = channel
                p[:user] = user
                p[:message_type] = declared(params)[:message_type]
                p[:text] = declared(params)[:text]
              end
            end
          end

          version :v1 do
            # POST /api/v1/channel/:channel_id/messages
            desc 'Create a chat message',
              named: 'create message',
              success: { code: 201, model: API::V1::Entities::Channel },
              failure: [
                { code: 401, model: API::Errors::UnauthorizedError },
                { code: 401, model: API::Errors::UnexpectedError },
                { code: 401, model: API::Errors::UserNotAMemberError }
              ]
            params do
              requires :user_id, type: String
              requires :channel_id, type: String
              requires :message_type, type: String, values: %w[plain invite]
              optional :text, type: String
            end

            post do
              result = Operations::Message::Create.new(**message_params).call
              error! authenticator_error(result.error), 401 if result.failure?
              present result.channel, with: API::V1::Entities::Channel
            end
          end
        end
      end
    end
  end
end
