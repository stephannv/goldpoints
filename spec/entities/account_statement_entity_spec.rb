require 'rails_helper'

RSpec.describe AccountStatementEntity, type: :entity do
  let!(:record) { create(:record) }
  let(:resource) { { occurrence_date: record.occurred_at.to_date, records: [record] } }
  let(:serializable_hash) { described_class.new(resource).serializable_hash }

  it 'exposes occurrence_date' do
    expect(serializable_hash[:occurrence_date]).to eq resource[:occurrence_date].iso8601
  end

  it 'exposes records' do
    expect(serializable_hash[:records]).to eq [RecordEntity.new(resource[:records].first).serializable_hash]
  end
end
