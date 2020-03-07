class PointsExpiration < ActiveRecord::Base
  monetize :amount_cents

  belongs_to :user

  protected def readonly?
    true
  end
end
