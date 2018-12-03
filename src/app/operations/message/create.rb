# frozen_string_literal: true

module Operations
  module Message
    class Create
      attr_reader :channel, :user, :message_type, :text

      def initialize(channel:, user:, message_type:, text: nil)
        @channel = channel
        @user = user
        @message_type = message_type
        @text = text
      end

      def call
        return failure(:user_not_a_member) unless member?

        message = ::Message.create!(
          user: user,
          channel: channel,
          message_type: message_type,
          text: text
        )

        success(message.channel)
      end

      private

      def member?
        ::Membership.where(channel: channel, user: user).exists?
      end

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
