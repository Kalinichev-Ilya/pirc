# frozen_string_literal: true

module Operations
  module Channel
    class Create
      attr_reader :owner, :channel_name

      def initialize(owner, channel_name)
        @owner = owner
        @channel_name = channel_name
      end

      def call
        channel = ::Channel.create!(owner: owner, name: channel_name)
        Membership.create!(channel: channel, user: owner)

        success(channel)
      rescue ActiveRecord::RecordNotUnique, ActiveRecord::RecordInvalid
        failure(:channel_already_exist)
      end

      private

      def success(channel)
        Result.new(channel, nil)
      end

      def failure(error)
        Result.new(nil, error)
      end

      Result = Struct.new(:channel, :error)
    end
  end
end
