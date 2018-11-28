# frozen_string_literal: true

module API
  module V1
    module Entities
      class Base < Grape::Entity
        format_with(:unix_timestamp) { |dt| dt.to_time.to_i }
      end
    end
  end
end
