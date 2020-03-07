require 'rails_helper'

RSpec.describe PointsExpirationEntity, type: :entity do
  let!(:record) { create(:record, group: :income) }
  let(:resource) { PointsExpiration.first }
  let(:serializable_hash) { described_class.new(resource).serializable_hash }

  it 'exposes points' do
    expect(serializable_hash[:points]).to eq resource.points
  end

  describe 'exposes country' do
    it 'exposes name' do
      expect(serializable_hash.dig(:country, :name)).to eq ISO3166::Country.new(resource.country_code).name
    end

    it 'exposes code' do
      expect(serializable_hash.dig(:country, :code)).to eq resource.country_code
    end
  end

  describe 'exposes amount' do
    it 'exposes value' do
      expect(serializable_hash.dig(:amount, :value)).to eq resource.amount.to_d.to_s
    end

    it 'exposes currency' do
      expect(serializable_hash.dig(:amount, :currency)).to eq resource.amount_currency
    end

    it 'exposes formatted' do
      expect(serializable_hash.dig(:amount, :formatted)).to eq resource.amount.formatted
    end
  end

  it 'exposes expires_on' do
    expect(serializable_hash[:expires_on]).to eq resource.expires_on.iso8601
  end
end
