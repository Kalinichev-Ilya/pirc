# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AccessToken do
  let (:params) { { essence: '123qwe123', fingerprint: '123qweasd123', expires_at: Time.current + 1.hours } }
  let(:token) { described_class.new(params) }

  it 'instance return valid true' do
    expect(token.valid?).to be_truthy
  end

  it 'success generate' do
    expect(AccessToken.generate!('whatever')).to be_a(AccessToken)
  end
end
