# frozen_string_literal: true

module API
  module V1
    module Users
      module Channels
        class Index < Grape::API
          before do
            authenticate!
          end

          helpers do
            def channels
              User.find(params[:id]).channels_last_post_desc
            end
          end

          version :v1 do
            desc 'Get user channels list',
                 named: 'channel list',
                 success: { code: 201, model: API::V1::Entities::Channel },
                 failure: [
                     { code: 401, model: API::Errors::UnauthorizedError },
                     { code: 401, model: API::Errors::UnexpectedError }
                 ]
            get do
              present channels, with: API::V1::Entities::Channel
            end
          end
        end
      end
    end
  end
end
