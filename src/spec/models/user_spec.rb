# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  describe '#create' do
    subject(:user) { build(:user) }

    context 'with valid password', focus: true do
      it 'success' do
        expect(user).to be_valid
      end
    end

    context 'with weak password' do
      subject(:user) { build(:user, :weak_pass) }

      it 'failure' do
        expect(user).to be_invalid
      end
    end
  end
end
