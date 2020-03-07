require 'rails_helper'

RSpec.describe Records::List, type: :api do
  describe 'Behavior' do
    let(:user_a) { create(:user) }
    let(:user_b) { create(:user) }
    let!(:record_a) { create(:record, group: :income, user: user_a) }
    let!(:record_b) { create(:record, group: :income, user: user_b) }

    it 'lists points expirations from given user' do
      result = described_class.call(user: user_a)

      expect(result.records).to eq [record_a]
    end
  end
end
