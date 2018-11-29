# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AccessToken do
  let(:access_token) { build(:access_token) }
  let(:user) { build(:user) }

  it 'success generate' do
    expect(access_token.generate!(user)).to be_instance_of(described_class)
  end
end
