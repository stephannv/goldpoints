class Record < ApplicationRecord
  as_enum :group, { income: 1, expense: -1 }, source: :group

  monetize :amount_cents, numericality: { greater_than: 0 }

  belongs_to :user

  validates :user_id, presence: true
  validates :group, presence: true
  validates :points, presence: true
  validates :country_code, presence: true
  validates :occurred_at, presence: true
  validates :expires_on, presence: true, if: :income?

  validates :points, numericality: { only_integer: true, greater_than: 0 }

  validates :description, length: { maximum: 32 }

  validates :country_code, inclusion: { in: EshopCountries::CODES }
end
