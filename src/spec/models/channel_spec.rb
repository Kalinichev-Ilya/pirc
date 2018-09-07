# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Channel do
  describe '#create' do
    subject(:channel) { build(:channel) }

    context 'with valid params' do
      it 'success' do
        expect(channel).to be_valid
      end
    end

    context 'with invalid params' do
      subject(:channel) { build(:channel, owner_id: nil) }

      it 'failure' do
        expect(channel).to be_invalid
      end
    end
  end
end
