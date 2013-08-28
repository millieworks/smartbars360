class CreateRules < ActiveRecord::Migration
  def change
    create_table :rules do |t|
      t.integer :smartbar_id
      t.integer :rule_type_id
      t.string :value

      t.timestamps
    end

    add_index :rules, [:smartbar_id, :rule_type_id]
    add_index :rules, [:rule_type_id, :smartbar_id]
  end
end
