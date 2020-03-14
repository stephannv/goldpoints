require 'rails_helper'

RSpec.describe GoldPoints::V1::AccountStatementsAPI, type: :api do
  mock_authenticate_request

  include_examples 'authenticate routes'

  describe 'GET /v1/account_statements' do
    let(:record) { build(:record, :with_fake_id) }
    let(:account_statement) { { occurrence_date: record.occurred_at.to_date, records: [record] } }

    before do
      allow(AccountStatements::List).to receive(:call)
        .with(user: current_user)
        .and_return(double(account_statements: [account_statement]))
    end

    it 'has http status OK' do
      get '/v1/account_statements'
      expect(response).to have_http_status(:ok)
    end

    it 'renders account statements' do
      get '/v1/account_statements'
      expect(response.body).to eq({ account_statements: [AccountStatementEntity.new(account_statement)] }.to_json)
    end
  end
end
