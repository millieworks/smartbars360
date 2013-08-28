class CreateTrackedUsers < ActiveRecord::Migration
  def change
    create_table :tracked_users do |t|
      t.string :public_user_id
      t.integer :customer_id
      t.integer :page_impressions, default: 0
      t.integer :visits, default: 0

      t.timestamps
    end

    add_index :tracked_users, :public_user_id, unique: true
    add_index :tracked_users, :customer_id
  end
end
