class CreateRuleTypes < ActiveRecord::Migration
  def change
    create_table :rule_types do |t|
      t.string :name
      t.string :indicator
      t.string :value_label
      t.string :value_operator
      t.string :default_value

      t.timestamps
    end
  end
end
