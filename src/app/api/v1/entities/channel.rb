# frozen_string_literal: true

module API
  module V1
    module Entities
      class Channel < Base
        expose :id
        expose :owner_id
        expose :name, as: :channel_name
      end
    end
  end
end
