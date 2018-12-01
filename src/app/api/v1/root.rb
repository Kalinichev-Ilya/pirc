# frozen_string_literal: true

module API
  module V1
    class Root < Grape::API
      mount API::V1::Users::Root
      mount API::V1::Auth::Root
      mount API::V1::Channels::Root
    end
  end
end
