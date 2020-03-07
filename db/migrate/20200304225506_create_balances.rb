class CreateBalances < ActiveRecord::Migration[6.0]
  def change
    create_view :balances
  end
end
