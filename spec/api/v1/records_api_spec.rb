require 'rails_helper'

RSpec.describe GoldPoints::V1::RecordsAPI, type: :api do
  mock_authenticate_request

  include_examples 'authenticate routes'

  describe 'GET /v1/records' do
    let(:record) { build(:record, :with_fake_id) }

    before { allow(Records::List).to receive(:call).with(user: current_user).and_return(double(records: [record])) }

    it 'has http status OK' do
      get '/v1/records'
      expect(response).to have_http_status(:ok)
    end

    it 'renders records' do
      get '/v1/records'
      expect(response.body).to eq({ records: [RecordEntity.new(record)] }.to_json)
    end
  end

  describe 'POST /v1/records' do
    let(:record) { build(:record, :with_fake_id) }
    let(:record_params) { attributes_for(:record).slice(:group, :points, :country_code, :occurred_at, :description) }

    before do
      allow(Records::Create).to receive(:call)
        .with(user: current_user, record_attributes: record_params)
        .and_return(double(record: record))
    end

    it 'has http status CREATED' do
      post '/v1/records', params: { record: record_params }
      expect(response).to have_http_status(:created)
    end

    it 'renders newly created record' do
      post '/v1/records', params: { record: record_params }
      expect(response.body).to eq({ record: RecordEntity.new(record) }.to_json)
    end
  end

  describe 'PUT /v1/records/:id' do
    let(:record) { build(:record, :with_fake_id) }
    let(:record_params) { attributes_for(:record).slice(:points) }

    before do
      allow(Records::Update).to receive(:call)
        .with(user: current_user, id: record.id, record_attributes: record_params)
        .and_return(double(record: record))
    end

    it 'has http status OK' do
      put "/v1/records/#{record.id}", params: { record: record_params }
      expect(response).to have_http_status(:ok)
    end

    it 'renders newly created record' do
      put "/v1/records/#{record.id}", params: { record: record_params }
      expect(response.body).to eq({ record: RecordEntity.new(record) }.to_json)
    end
  end

  describe 'DELETE /v1/records/:id' do
    let(:record_id) { 'some-id' }

    before do
      allow(Records::Destroy).to receive(:call)
        .with(user: current_user, id: record_id)
    end

    it 'has http status NO_CONTENT' do
      delete "/v1/records/#{record_id}"
      expect(response).to have_http_status(:no_content)
    end
  end
end
