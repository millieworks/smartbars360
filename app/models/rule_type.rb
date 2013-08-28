class RuleType < ActiveRecord::Base
  attr_accessible :default_value, :indicator, :name, :value_label, :value_operator

  belongs_to :rules

  validates_presence_of :default_value, :indicator, :name

  scope :sorted, order: "name ASC"
end