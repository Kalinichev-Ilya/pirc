# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Helpers::Encryptor, type: :request do
  context '.encode' do
    let(:str) { 'whatever' }

    it 'returns hash string' do
      expect(described_class.encode(str)).to be_instance_of(String)
    end
  end
end
