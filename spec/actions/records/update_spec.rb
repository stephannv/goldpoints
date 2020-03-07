require 'rails_helper'

RSpec.describe Records::Update, type: :api do
  describe 'Behavior' do
    let!(:record) { create(:record) }
    let(:group) { %w[income expense].sample }
    let(:record_attributes) do
      attributes_for(:record).slice(:points, :country_code, :occurred_at, :description).merge(group: group)
    end
    let(:result) { described_class.call(user: record.user, id: record.id, record_attributes: record_attributes) }

    context 'when attributes are valid' do
      it 'creates a new record calculating amount and expiration date' do
        record = result.record
        expect(record.group).to eq record_attributes[:group].to_sym
        expect(record.points).to eq record_attributes[:points]
        expect(record.country_code).to eq record_attributes[:country_code]
        expect(record.occurred_at).to eq record_attributes[:occurred_at]
        expect(record.description).to eq record_attributes[:description]
        expect(record.amount).to eq PointsConverter.convert_to_money(
          points: record_attributes[:points], country_code: record_attributes[:country_code]
        )
      end

      context 'when is a income record' do
        let(:group) { 'income' }

        it 'calculates expiration date' do
          record = result.record
          expect(record.expires_on).to eq record_attributes[:occurred_at] + 1.year
        end
      end

      context 'when is an expense record' do
        let(:group) { 'expense' }

        it 'doesn`t calculate expiration date' do
          record = result.record
          expect(record.expires_on).to be_nil
        end
      end
    end

    context 'when attributes are invalid' do
      let(:record_attributes) { { points: 0 } }

      it 'raises RecordInvalid error' do
        expect { result }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end
