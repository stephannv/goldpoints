class User < ApplicationRecord
  has_secure_password

  has_many :records, dependent: :destroy
  has_many :balances # rubocop:disable Rails/HasManyOrHasOneDependent
  has_many :points_expirations # rubocop:disable Rails/HasManyOrHasOneDependent

  validates :email, presence: true
  validates :password_digest, presence: true

  validates :email, uniqueness: { case_sensitive: false }

  validates :email, length: { maximum: 300 }
  validates :password, length: { maximum: 128 }
end
