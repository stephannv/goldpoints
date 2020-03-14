require 'rails_helper'

RSpec.describe Users::AuthenticateByToken, type: :api do
  describe 'Behavior' do
    let(:user) { create(:user) }
    let(:token) { Token.encode(payload: { user_id: user.id }, expiration_time_in_minutes: 5) }
    let(:authorization_header) { { 'Authorization' => "Basic #{token}" } }

    context 'when token verification is valid' do
      it 'decodes token and find user' do
        result = described_class.call(authorization_header: authorization_header)

        expect(result.user).to eq user
      end
    end

    context 'when token verification is invalid' do
      before { allow(Token).to receive(:decode).and_raise(JWT::VerificationError) }

      it 'fails context' do
        result = described_class.call(authorization_header: authorization_header)

        expect(result.user).to be_nil
        expect(result).to be_failure
      end
    end
  end
end
