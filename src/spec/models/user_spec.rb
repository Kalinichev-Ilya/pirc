# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  describe '#create' do
    subject(:user) { build(:user) }

    context 'with valid password' do
      it 'success' do
        expect(user).to be_valid
      end
    end

    context 'with invalid password' do
      subject(:user) { build(:user, password_digest: '') }

      it 'failure' do
        expect(user).to be_invalid
      end
    end
  end
end
