require 'rails_helper'

RSpec.describe GoldPoints::V1::BaseAPI, type: :api do
  describe '#authenticate_request!' do
    subject { Class.new(GoldPoints::V1::BaseAPI) }

    def app
      subject
    end

    context 'when route is public' do
      before do
        subject.route_setting :auth, public: true
        subject.get '/example' do
          'message'
        end
      end

      it 'doesn`t authenticate request' do
        get '/v1/example'
        expect(response.body).to eq('message'.to_json)
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when route isn`t public' do
      context 'when authorization header isn`t present' do
        before do
          subject.get '/example' do
            'message'
          end
        end

        it 'blocks request' do
          get '/v1/example'
          expect(response.body).to eq({ message: 'Unauthorized' }.to_json)
          expect(response).to have_http_status(:unauthorized)
        end
      end

      context 'when authorization header is present' do
        let(:headers) { { 'Authorization' => 'Bearer token.here' } }

        before do
          subject.get '/example' do
            'message'
          end
        end

        context 'when authorization header is invalid' do
          before do
            allow(Users::AuthenticateByToken).to receive(:call)
              .with(authorization_header: headers['Authorization'])
              .and_return(double(user: nil))
          end

          it 'blocks request' do
            get '/v1/example', headers: headers
            expect(response.body).to eq({ message: 'Unauthorized' }.to_json)
            expect(response).to have_http_status(:unauthorized)
          end
        end

        context 'when authorization header is valid' do
          before do
            allow(Users::AuthenticateByToken).to receive(:call)
              .with(authorization_header: headers['Authorization'])
              .and_return(double(user: double(:user)))
          end

          it 'authenticates request' do
            get '/v1/example', headers: headers
            expect(response.body).to eq('message'.to_json)
            expect(response).to have_http_status(:ok)
          end
        end
      end
    end
  end
end
