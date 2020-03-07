class CreatePointsExpirations < ActiveRecord::Migration[6.0]
  def change
    create_view :points_expirations
  end
end
