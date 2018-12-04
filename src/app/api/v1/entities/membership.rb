# frozen_string_literal: true

module API
  module V1
    module Entities
      class Membership < Base
        expose :id
        expose :user_id
        expose :channel_id
        expose :is_favorite
      end
    end
  end
end
