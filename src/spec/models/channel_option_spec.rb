# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ChannelOption do
  describe '#create' do
    subject(:option) { build(:channel_option) }

    context 'with valid params' do
      it 'success' do
        expect(option).to be_valid
      end
    end

    context 'with invalid params' do
      subject(:option) { build(:channel_option, user_id: nil) }

      it 'failure' do
        expect(option).to be_invalid
      end
    end
  end
end
