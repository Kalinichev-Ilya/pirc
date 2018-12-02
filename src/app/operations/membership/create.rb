# frozen_string_literal: true

module Operation
  module Membership
    class Create
      attr_reader :user, :channel

      def initialize(user, channel)
        @user = user
        @channel = channel
      end

      def call
        Membership.create!(channel: channel, user: user)
      rescue ActiveRecord::RecordNotUnique, ActiveRecord::RecordInvalid
        failure(:member_exist)
      end

      private

      def success(channel)
        Result.new(channel, nil)
      end

      def failure(error)
        Result.new(nil, error)
      end

      Result = Struct.new(:channel, :error) do
        def failure?
          error.present?
        end
      end
    end
  end
end
