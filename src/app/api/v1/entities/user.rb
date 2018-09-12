# frozen_string_literal: true

module V1
  module Entities
    class User < Grape::Entity
      expose :id
      expose :username
      expose :password_digest
    end
  end
end
