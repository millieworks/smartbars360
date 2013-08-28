class RuleDecorator < Draper::Base
  decorates :rule

  def display_format
    h.content_tag :div, rule.name + (rule.rule_type.value_label.blank? ? '' : " (" + rule.rule_type.value_label + ": " + rule.value + ")")
  end
end
