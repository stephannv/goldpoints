require 'rails_helper'

RSpec.describe GoldPoints::V1::CountriesAPI, type: :api do
  mock_authenticate_request

  include_examples 'authenticate routes'

  describe 'GET /v1/countries' do
    let(:country) { ISO3166::Country['BR'] }

    before do
      allow(Countries::List).to receive(:call).and_return(double(countries: [country]))
    end

    it 'has http status OK' do
      get '/v1/countries'
      expect(response).to have_http_status(:ok)
    end

    it 'renders countries' do
      get '/v1/countries'
      expect(response.body).to eq({ countries: [CountryEntity.new(country)] }.to_json)
    end
  end
end
