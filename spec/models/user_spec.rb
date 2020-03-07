require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Relations' do
    it { is_expected.to have_many(:records).dependent(:destroy) }
    it { is_expected.to have_many(:balances) }
    it { is_expected.to have_many(:points_expirations) }
  end

  describe 'Configurations' do
    it { is_expected.to have_secure_password }
  end

  describe 'Validations' do
    subject { build(:user) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password_digest) }

    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }

    it { is_expected.to validate_length_of(:email).is_at_most(300) }
    it { is_expected.to validate_length_of(:password).is_at_most(128) }
  end
end
