class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users, id: :uuid do |t|
      t.string :email, null: false, index: { unique: true }, limit: 300
      t.string :password_digest, null: false

      t.timestamps
    end
  end
end
