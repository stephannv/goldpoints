require 'rails_helper'

RSpec.describe GoldPoints::V1::PointsExpirationsAPI, type: :api do
  mock_authenticate_request

  include_examples 'authenticate routes'

  describe 'GET /v1/points_expirations' do
    let(:points_expiration) { build(:points_expiration) }

    before do
      allow(PointsExpirations::List).to receive(:call)
        .with(user: current_user)
        .and_return(double(points_expirations: [points_expiration]))
    end

    it 'has http status OK' do
      get '/v1/points_expirations'
      expect(response).to have_http_status(:ok)
    end

    it 'renders points_expirations' do
      get '/v1/points_expirations'
      expect(response.body).to eq({ points_expirations: [PointsExpirationEntity.new(points_expiration)] }.to_json)
    end
  end
end
