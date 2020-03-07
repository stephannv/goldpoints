require 'rails_helper'

RSpec.describe CountryEntity, type: :entity do
  let(:resource) { ISO3166::Country.all.sample }
  let(:serializable_hash) { described_class.new(resource).serializable_hash }

  it 'exposes name' do
    expect(serializable_hash[:name]).to eq resource.name
  end

  it 'exposes code' do
    expect(serializable_hash[:code]).to eq resource.alpha2
  end
end
