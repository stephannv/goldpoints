require 'rails_helper'

RSpec.describe PointsExpirations::List, type: :api do
  describe 'Behavior' do
    let(:user_a) { create(:user) }
    let(:user_b) { create(:user) }
    let!(:record_a) { create(:record, group: :income, user: user_a) }
    let!(:record_b) { create(:record, group: :income, user: user_b) }

    it 'lists points expirations from given user' do
      result = described_class.call(user: user_a)

      expect(result.points_expirations.size).to eq 1
      expect(result.points_expirations.first).to be_a(PointsExpiration)
      expect(result.points_expirations.map(&:user)).to eq [user_a]
    end
  end
end
