require 'rails_helper'

RSpec.describe Record, type: :model do
  describe 'Relations' do
    it { is_expected.to belong_to(:user) }
  end

  describe 'Configurations' do
    it { is_expected.to monetize(:amount) }

    it 'has group enum' do
      expect(described_class.groups.hash).to eq('expense' => -1, 'income' => 1)
    end
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:user_id) }
    it { is_expected.to validate_presence_of(:group) }
    it { is_expected.to validate_presence_of(:points) }
    it { is_expected.to validate_presence_of(:country_code) }
    it { is_expected.to validate_presence_of(:occurred_at) }

    context 'when is income' do
      subject { described_class.incomes.new }
      it { is_expected.to validate_presence_of(:expires_on) }
    end

    context 'when is expense' do
      subject { described_class.expenses.new }
      it { is_expected.to_not validate_presence_of(:expires_on) }
    end

    it { is_expected.to validate_numericality_of(:points).is_greater_than(0) }
    it { is_expected.to validate_numericality_of(:amount).is_greater_than(0) }

    it { is_expected.to validate_length_of(:description).is_at_most(32) }

    it { is_expected.to validate_inclusion_of(:country_code).in_array(EshopCountries::CODES) }
  end
end
