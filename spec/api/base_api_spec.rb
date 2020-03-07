require 'rails_helper'

RSpec.describe GoldPoints::BaseAPI, type: :api do
  describe 'Mounted apps' do
    it 'mounts GoldPoints::V1::BaseAPI app' do
      expect(described_class.routes).to match(GoldPoints::V1::BaseAPI.routes)
    end
  end
end
