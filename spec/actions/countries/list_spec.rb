require 'rails_helper'

RSpec.describe Countries::List, type: :api do
  describe 'Behavior' do
    it 'lists returns eshop countries' do
      result = described_class.call

      expect(result.countries.map(&:alpha2)).to match_array(EshopCountries::CODES)
    end
  end
end
