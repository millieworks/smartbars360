class SmartbarSelector

  def initialize(args)
    @tracked_user = TrackedUser.find(args[:tracked_user_id])
    @smartbars = customer_smartbars_matching_url(args[:customer_id], args[:url])
  end

  def get_smartbar_id
    @smartbars.each do |s|
      return s.id if user_yet_to_take_action?(s) && (s.has_no_rules || rules_apply(s.rules, s.rule_grouping))
    end
    nil
  end

  def customer_smartbars_matching_url(customer_id, url)
    Smartbar.find_all_by_customer_id(customer_id, order: "name ASC").select { |s| s.url_matches?(url) }
  end

  def user_yet_to_take_action?(smartbar)
    TrackedUserAction.find_by_tracked_user_id_and_smartbar_id(@tracked_user.id, smartbar.id).nil?
  end

  def rules_apply(rules, rule_grouping)
    applicable_rules = rules.collect { |rule| rule.applies_to_tracked_user?(@tracked_user) }
    rule_grouping == "and" ? applicable_rules.all? { |ar| ar } : applicable_rules.any? { |ar| ar }
  end
end
