# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Operations::AccessToken::Generate, type: :request do
  context '.call' do
    let(:user) { create(:user) }

    it 'returns valid access token' do
      expect(described_class.new(user).call).to be_instance_of(AccessToken)
    end
  end
end
