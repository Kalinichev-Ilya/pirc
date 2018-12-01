# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Membership do
  describe '#create' do
    context 'with valid params' do
      subject(:membership) { build(:membership) }

      it 'success' do
        expect(membership).to be_valid
      end
    end

    context 'with invalid params' do
      subject(:membership) { build(:membership, user_id: nil) }

      it 'failure' do
        expect(membership).to be_invalid
      end
    end
  end
end
