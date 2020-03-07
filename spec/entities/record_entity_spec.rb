require 'rails_helper'

RSpec.describe RecordEntity, type: :entity do
  let(:resource) { build(:record, :with_fake_id) }
  let(:serializable_hash) { described_class.new(resource).serializable_hash }

  it 'exposes id' do
    expect(serializable_hash[:id]).to eq resource.id
  end

  it 'exposes points' do
    expect(serializable_hash[:points]).to eq resource.points
  end

  it 'exposes group' do
    expect(serializable_hash[:group]).to eq resource.group
  end

  it 'exposes description' do
    expect(serializable_hash[:description]).to eq resource.description
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

  it 'exposes occurred_at' do
    expect(serializable_hash[:occurred_at]).to eq resource.occurred_at.iso8601
  end

  it 'exposes expires_on' do
    expect(serializable_hash[:expires_on]).to eq resource.expires_on.iso8601
  end
end
