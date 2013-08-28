class AddDataToTrackedUserActions < ActiveRecord::Migration
  def change
    add_column :tracked_user_actions, :data, :string
  end
end
