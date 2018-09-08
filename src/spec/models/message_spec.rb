# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Message do
  describe '#create' do
    subject(:message) { build(:message) }

    context 'with valid params' do
      it 'success' do
        expect(message).to be_valid
      end
    end

    context 'with invalid params' do
      subject(:message) { build(:message, user_id: nil) }

      it 'failure' do
        expect(message).to be_invalid
      end
    end
  end
end
