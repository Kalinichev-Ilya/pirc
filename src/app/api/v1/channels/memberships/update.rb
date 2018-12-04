# frozen_string_literal: true

module API
  module V1
    module Channels
      module Memberships
        class Update < Grape::API
          before do
            authenticate!
          end

          helpers do
            def membership
              Membership.find_by!(channel_id: params[:id], user_id: current_user.id)
            end
          end

          version :v1 do
            # PATCH /api/v1/channel/:channel_id/membership
            desc 'Set channel as favorite',
              named: 'favorite channel',
              success: { code: 201, model: API::V1::Entities::Membership },
              failure: [
                { code: 401, model: API::Errors::UnauthorizedError },
                { code: 401, model: API::Errors::UnexpectedError }
              ]
            params do
              requires :is_favorite, type: Boolean
            end

            patch do
              membership.update!(is_favorite: declared(params)[:is_favorite])
              present membership, with: API::V1::Entities::Membership
            end
          end
        end
      end
    end
  end
end
