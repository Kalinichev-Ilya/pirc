# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Operations::Message::Create do
  context '.call' do
    let(:user) { create(:user) }
    let(:channel) { create(:channel) }
    let(:membership) { create(:membership, channel_id: channel.id, user_id: user.id) }

    let(:message_params) do
      {
        channel: channel,
        user: user,
        message_type: 'plain',
        text: nil
      }
    end

    context 'success' do
      it 'returns valid channel' do
        membership
        expect(described_class.new(**message_params).call.channel).to be_instance_of(Channel)
      end
    end

    context 'failure' do
      let(:membership) { create(:membership, channel_id: channel.id) }

      it 'returns :user_not_a_member error' do
        membership
        expect(described_class.new(**message_params).call.error).to eq(:user_not_a_member)
      end
    end
  end
end
