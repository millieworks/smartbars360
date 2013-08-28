class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :name
      t.string :api_key

      t.timestamps
    end
    add_index :customers, :api_key, :unique => true
  end
end
