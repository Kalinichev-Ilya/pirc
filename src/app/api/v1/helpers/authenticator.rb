# frozen_string_literal: true

module API
  module V1
    module Helpers
      class Authenticator
        extend ActiveSupport::Concern

        def self.authenticate(email: , password:)
          user = User.find_by!(email: email)

        end
      end
    end
  end
end
