require 'rails_helper'

RSpec.describe Token, type: :lib do
  let(:payload) { { 'key' => 'value' } }
  let(:expiration_time_in_minutes) { 20 }
  let!(:exp) { (Time.zone.now + expiration_time_in_minutes.minutes).to_i }
  let!(:token) { described_class.encode(payload: payload, expiration_time_in_minutes: expiration_time_in_minutes) }

  describe '.encode' do
    it 'encodes payload with expiration time' do
      jwt_token = JWT.encode(payload.merge('exp' => exp), Rails.application.credentials[:secret_key_base])
      expect(token).to eq jwt_token
    end
  end

  describe '.decode' do
    it 'decodes token and returns payload' do
      expect(described_class.decode(token: token)).to eq('key' => 'value', 'exp' => exp)
    end
  end
end
