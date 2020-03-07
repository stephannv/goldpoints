require 'rails_helper'

RSpec.describe Users::Create, type: :api do
  describe 'Behavior' do
    let(:result) { described_class.call(user_attributes: user_attributes) }

    context 'when attributes are valid' do
      let(:user_attributes) { attributes_for(:user) }

      it 'creates a new user' do
        expect { result }.to change(User, :count).by(1)
        expect(result.user).to be_persisted
        expect(result.user.email).to eq user_attributes[:email]
        expect(result.user.password).to eq user_attributes[:password]
      end
    end

    context 'when attributes are invalid' do
      let(:user_attributes) { { email: '' } }

      it 'raises RecordInvalid error' do
        expect { result }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end
