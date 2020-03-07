require 'rails_helper'

RSpec.describe UserEntity, type: :entity do
  let(:resource) { build(:user, :with_fake_id) }
  let(:serializable_hash) { described_class.new(resource).serializable_hash }

  it 'exposes id' do
    expect(serializable_hash[:id]).to eq resource.id
  end

  it 'exposes email' do
    expect(serializable_hash[:email]).to eq resource.email
  end
end
