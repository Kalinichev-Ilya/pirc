# frozen_string_literal: true

module Operations
  module AccessToken
    class Generate
      attr_reader :user

      def initialize(user)
        @user = user
      end

      def call
        ::AccessToken.create!(build_params)
      end

      private

      def build_params
        Hash.new({}).tap do |params|
          params[:user] = user
          params[:essence] = SecureRandom.hex
          params[:essence_hash] = Helpers::Encryptor.encode(params[:essence])
          params[:refresh_token] = SecureRandom.hex
          params[:refresh_token_hash] = Helpers::Encryptor.encode(params[:essence])
          params[:expires_at] = 1.hour.since
        end
      end
    end
  end
end
