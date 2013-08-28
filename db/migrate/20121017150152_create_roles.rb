class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :name
      t.timestamps
    end

    create_table :roles_users do |t|
      t.references :role, :user
    end

    #add_index :roles_users, [:role_id, :user_id]
    #add_index :roles_users, [:user_id, :role_id]
  end
end
