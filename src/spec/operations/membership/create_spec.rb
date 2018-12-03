# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Operations::Membership::Create do
  context '.call' do
    context 'success' do
      let(:user) { create(:user) }
      let(:channel) { create(:channel) }

      it 'returns valid channel' do
        expect(described_class.new(user, channel).call.channel).to be_instance_of(Channel)
        # expect(channel.users).to change(channel.users, :count).by(1) # TODO
      end
    end

    context 'failure' do
      let(:owner) { create(:user) }
      let(:channel) { create(:channel, owner_id: owner.id) }
      let(:membership) { create(:membership, user_id: owner.id, channel_id: channel.id) }

      it 'returns member_exist error' do
        membership
        expect(described_class.new(owner, channel).call.error).to eq(:member_exist)
      end
    end
  end
end
