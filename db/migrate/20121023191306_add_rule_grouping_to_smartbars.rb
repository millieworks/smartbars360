class AddRuleGroupingToSmartbars < ActiveRecord::Migration
  def change
    add_column :smartbars, :rule_grouping, :string, default: "and"
  end
end
