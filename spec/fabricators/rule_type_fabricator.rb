Fabricator(:rule_type) do
  default_value "0"
  indicator "Indicator"
  name "My Rule"
  value_label "Value in units"
  value_operator "=="
end

Fabricator(:page_views_rule_type, from: :rule_type) do
  default_value "1"
  indicator "PageImpressions"
  name "nth page view"
  value_label nil
  value_operator "=="
end

Fabricator(:more_than_x_page_views_rule_type, from: :page_views_rule_type) do
  name "More than X page views"
  value_label "Number of page views"
  value_operator ">"
end

Fabricator(:less_than_x_page_views_rule_type, from: :page_views_rule_type) do
  name "Less than X page views"
  value_label "Number of page views"
  value_operator "<"
end

Fabricator(:every_nth_page_view_rule_type, from: :page_views_rule_type) do
  name "Every nth page view"
  value_label "Number of page views"
  value_operator "%"
end

Fabricator(:visits_rule_type, from: :rule_type) do
  default_value "1"
  indicator "Visits"
  name "nth visit"
  value_label nil
  value_operator "=="
end

Fabricator(:more_than_x_visits_rule_type, from: :visits_rule_type) do
  name "More than X visits"
  value_label "Number of visits"
  value_operator ">"
end

Fabricator(:less_than_x_visits_rule_type, from: :visits_rule_type) do
  name "Less than X visits"
  value_label "Number of visits"
  value_operator "<"
end

Fabricator(:every_nth_visit_rule_type, from: :visits_rule_type) do
  name "Every nth visit"
  value_label "Number of visits"
  value_operator "%"
end

Fabricator(:days_since_last_visit, from: :rule_type) do
  indicator "TrackedUserUpdatedAt"
  name "Days since last visit"
  value_label "Number of days"
  value_operator ">="
end

Fabricator(:javascript_rule_type, from: :rule_type) do
  indicator "Javascript"
end
