class CreateTrackedUserActions < ActiveRecord::Migration
  def change
    create_table :tracked_user_actions do |t|
      t.integer :tracked_user_id
      t.integer :smartbar_id

      t.timestamps
    end

    add_index :tracked_user_actions, [:tracked_user_id, :smartbar_id]
    add_index :tracked_user_actions, [:smartbar_id, :tracked_user_id]
  end
end
