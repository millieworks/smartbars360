class Rule < ActiveRecord::Base
  attr_accessible :rule_type_id, :value, :smartbar_id

  belongs_to :smartbar
  belongs_to :rule_type

  validates_presence_of :rule_type_id, :smartbar_id #value

  delegate :name, :indicator, :value_operator, to: :rule_type

  before_create :set_fallback_value

  def set_fallback_value
    self.value = self.rule_type.default_value if self.value.blank?
  end

  def applies_to_tracked_user?(tracked_user)
    return tracking_stats_rule?(tracked_user) if %w(PageImpressions Visits).include?(self.indicator)
    return last_updated_rule?(tracked_user) if self.indicator == "TrackedUserUpdatedAt"
    return javascript_rule?
  end

  def tracking_stats_rule?(tracked_user)
    users_value = eval("tracked_user.#{self.indicator.underscore}")
    eval("#{users_value} #{value_operator} #{value} #{value_operator == "%" ? '== 0' : ''}")
  end

  def last_updated_rule?(tracked_user)
    eval("#{Time.at(Time.now - value.to_i.days).to_i} #{value_operator} #{Time.at(tracked_user.updated_at).to_i}")
  end

  def javascript_rule?
    self.indicator.include?("Javascript")
  end
end
