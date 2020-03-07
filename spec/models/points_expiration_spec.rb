require 'rails_helper'

RSpec.describe PointsExpiration, type: :model do
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
