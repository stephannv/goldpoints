require 'rails_helper'

RSpec.describe Users::AuthenticateByCredentials, type: :api do
  describe 'Behavior' do
    let(:user) { create(:user) }

    context 'when credentials are valid' do
      it 'returns authentication jwt token' do
        result = described_class.call(credentials: { email: user.email, password: user.password })
        payload = Token.decode(token: result.token)

        expect(payload[:user_id]).to eq user.id
        expect(Time.zone.at(payload[:exp]).to_date).to be_after(364.days.from_now)
      end
    end

    context 'when credentials are invalid' do
      it 'fails context' do
        result = described_class.call(credentials: { email: user.email, password: 'wrongpassword' })

        expect(result).to be_failure
        expect(result.user).to be_nil
      end
    end
  end
end
