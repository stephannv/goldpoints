require 'rails_helper'

RSpec.describe AccountStatements::List, type: :api do
  describe 'Behavior' do
    let(:user) { create(:user) }
    let(:other_user) { create(:user) }

    let!(:record_a) { create(:record, user: user, occurred_at: Time.zone.parse('2020/03/01')) }
    let!(:record_b) { create(:record, user: user, occurred_at: Time.zone.parse('2020/04/05')) }
    let!(:record_c) { create(:record, user: user, occurred_at: Time.zone.parse('2020/04/05')) }
    let!(:record_d) { create(:record, user: user, occurred_at: Time.zone.parse('2020/03/01')) }
    let!(:record_from_other_user) { create(:record, user: other_user, occurred_at: Time.zone.parse('2020/01/01')) }

    it 'returns given user`s records grouped by occurrence date' do
      result = described_class.call(user: user)

      expect(result.account_statements.size).to eq 2

      expect(result.account_statements.first[:occurrence_date].iso8601).to eq '2020-04-05'
      expect(result.account_statements.first[:records]).to match([record_b, record_c])

      expect(result.account_statements.last[:occurrence_date].iso8601).to eq '2020-03-01'
      expect(result.account_statements.last[:records]).to match([record_a, record_d])
    end
  end
end
