require 'rails_helper'

RSpec.describe Records::Destroy, type: :api do
  describe 'Behavior' do
    let!(:record) { create(:record) }

    context 'when record with given id exists' do
      it 'destroys the record' do
        expect do
          described_class.call(user: record.user, id: record.id)
        end.to change(Record, :count).by(-1)

        expect { record.reload }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'when record with given id doesn`t exist' do
      let(:user) { create(:user) }

      it 'raises an error' do
        expect { described_class.call(user: user, id: record.id) }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
