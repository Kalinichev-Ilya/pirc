# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Operations::Channel::Create do
  context '.call' do
    context 'success' do
      let(:owner) { create(:user) }
      let(:channel_name) { 'whatever' }

      it 'returns valid channel' do
        expect(described_class.new(owner, channel_name).call.channel).to be_instance_of(Channel)
      end
    end

    context 'failure' do
      let(:channel_name) { 'not_uniq_name' }
      let(:owner) { create(:user) }
      let(:channel) { create(:channel, owner: owner, name: channel_name) }

      it 'returns channel_already_exist error' do
        channel
        expect(described_class.new(owner, channel_name).call.error).to eq(:channel_already_exist)
      end
    end
  end
end
