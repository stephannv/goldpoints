require 'rails_helper'

RSpec.describe Balance, type: :model do
  describe 'Relations' do
    it { is_expected.to belong_to(:user) }
  end

  describe 'Configurations' do
    it { is_expected.to monetize(:amount) }

    it 'is readonly' do
      expect(subject.send(:readonly?)).to be_truthy
    end
  end
end
