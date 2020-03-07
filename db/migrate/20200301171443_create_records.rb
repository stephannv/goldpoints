class CreateRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :records, id: :uuid do |t|
      t.references :user, null: false, index: true, foreign_key: true, type: :uuid
      t.integer :group, null: false
      t.integer :points, null: false
      t.string :country_code, limit: 2, null: false
      t.datetime :occurred_at, null: false, index: true
      t.date :expires_on, index: { where: 'expires_on IS NOT NULL' }
      t.monetize :amount
      t.string :description, limit: 32

      t.timestamps null: false
    end
  end
end
