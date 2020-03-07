require 'rails_helper'

RSpec.describe GoldPoints::V1::UsersAPI, type: :api do
  describe 'POST /v1/users' do
    let(:user) { build(:user, :with_fake_id) }
    let(:user_params) { attributes_for(:user).slice(:email, :password, :password_confirmation) }

    before do
      allow(Users::Create).to receive(:call)
        .with(user_attributes: user_params)
        .and_return(double(user: user))
    end

    it 'has http status CREATED' do
      post '/v1/users', params: { user: user_params }
      expect(response).to have_http_status(:created)
    end

    it 'renders newly created user' do
      post '/v1/users', params: { user: user_params }
      expect(response.body).to eq({ user: UserEntity.new(user) }.to_json)
    end
  end
end
