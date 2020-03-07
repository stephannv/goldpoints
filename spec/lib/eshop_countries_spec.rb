require 'rails_helper'

RSpec.describe EshopCountries, type: :lib do
  describe 'Constants' do
    it 'has CODES constant' do
      codes = %w[
        AT AU BE BG CA CH CY CZ DE DK EE ES FI FR GB GR HR HU IE IL IT JP LT LU LV MT MX NL NO NZ PL PT RO RU SE SI SK
        US ZA
      ]

      expect(described_class::CODES).to eq codes
    end
  end
end
