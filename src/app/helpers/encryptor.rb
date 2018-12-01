# frozen_string_literal: true

module Helpers
  module Encryptor
    class << self
      def encode(str)
        Digest::SHA2.hexdigest(str)
      end
    end
  end
end
