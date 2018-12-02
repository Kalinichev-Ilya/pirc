# frozen_string_literal: true

module API
  module V1
    module Entities
      class Channel < Base
        expose :id
        expose :owner_id
        expose :name, as: :channel_name

        expose :users do |instance|
          API::V1::Entities::User.represent(instance.users)
        end
      end
    end
  end
end
