require 'rails_helper'

RSpec.describe PointsConverter, type: :lib do
  describe 'Constants' do
    it 'has RATES constant' do
      rates = {
        'AUD' => 1,
        'CAD' => 1,
        'CHF' => 1,
        'CZK' => 20,
        'DKK' => 0.1,
        'EUR' => 1,
        'GBP' => 1,
        'JPY' => 1,
        'MXN' => 20,
        'NOK' => 0.1,
        'NZD' => 1,
        'PLN' => 5,
        'RUB' => 1,
        'SEK' => 0.1,
        'USD' => 1,
        'ZAR' => 10
      }

      expect(described_class::RATES).to eq rates
    end
  end

  describe 'Class methods' do
    describe '.eshop_currency_by_country_code' do
      let(:exceptions_country) { %w[HU HR IL RO BG] }

      context 'when country code is HU, HR, IL, RO or BG' do
        it 'returns EUR currency' do
          exceptions_country.each do |country_code|
            currency = described_class.eshop_currency_by_country_code(country_code)

            expect(currency).to eq 'EUR'
          end
        end
      end

      context 'when country code isn`t HU, HR, IL, RO or BG' do
        it 'returns native currency' do
          (EshopCountries::CODES - exceptions_country).each do |country_code|
            currency = described_class.eshop_currency_by_country_code(country_code)

            expect(currency).to eq ISO3166::Country.new(country_code).currency_code
          end
        end
      end
    end
  end
end
