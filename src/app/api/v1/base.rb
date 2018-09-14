# frozen_string_literal: true

module API
  module V1
    class Base < Grape::API
      mount API::V1::Test
      mount API::V1::Users::Create
    end
  end
end
