require 'rails_helper'

RSpec.describe GoldPoints::V1::AuthenticationsAPI, type: :api do
  describe 'POST /v1/authentications' do
    let(:token) { Faker::Lorem.word }
    let(:credentials_params) { attributes_for(:user).slice(:email, :password) }

    context 'when authentication is successfull' do
      before do
        allow(Users::AuthenticateByCredentials).to receive(:call)
          .with(credentials: credentials_params)
          .and_return(double(success?: true, token: token))
      end

      it 'has http status CREATED' do
        post '/v1/authentications', params: { credentials: credentials_params }

        expect(response).to have_http_status(:created)
      end

      it 'renders authentication token' do
        post '/v1/authentications', params: { credentials: credentials_params }
        expect(response.body).to eq({ token: token }.to_json)
      end
    end

    context 'when authentication fails' do
      before do
        allow(Users::AuthenticateByCredentials).to receive(:call)
          .with(credentials: credentials_params)
          .and_return(double(success?: false))
      end

      it 'has http status UNAUTHORIZED' do
        post '/v1/authentications', params: { credentials: credentials_params }
        expect(response).to have_http_status(:unauthorized)
      end

      it 'renders unauthorized message' do
        post '/v1/authentications', params: { credentials: credentials_params }
        expect(response.body).to eq({ message: 'Unauthorized' }.to_json)
      end
    end
  end
end
