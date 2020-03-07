require 'rails_helper'

RSpec.describe GoldPoints::V1::BalancesAPI, type: :api do
  mock_authenticate_request

  include_examples 'authenticate routes'

  describe 'GET /v1/balances' do
    let(:balance) { build(:balance) }

    before do
      allow(Balances::List).to receive(:call)
        .with(user: current_user)
        .and_return(double(balances: [balance]))
    end

    it 'has http status OK' do
      get '/v1/balances'
      expect(response).to have_http_status(:ok)
    end

    it 'renders balances' do
      get '/v1/balances'
      expect(response.body).to eq({ balances: [BalanceEntity.new(balance)] }.to_json)
    end
  end
end
