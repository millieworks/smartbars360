Fabricator(:rule) do
  smartbar_id 1
  rule_type_id 1
  value "1"
end

Fabricator(:first_page_view, from: :rule) do
  rule_type { Fabricate(:page_views_rule_type) }
  value "1"
end

Fabricator(:page_views, from: :rule) do
  rule_type { Fabricate(:page_views_rule_type) }
end

Fabricator(:more_than_x_page_views, from: :rule) do
  rule_type { Fabricate(:more_than_x_page_views_rule_type) }
end

Fabricator(:less_than_x_page_views, from: :rule) do
  rule_type { Fabricate(:less_than_x_page_views_rule_type) }
end

Fabricator(:every_nth_page_view, from: :rule) do
  rule_type { Fabricate(:every_nth_page_view_rule_type) }
end

Fabricator(:first_visit, from: :rule) do
  rule_type { Fabricate(:visits_rule_type) }
  value "1"
end

Fabricator(:visits, from: :rule) do
  rule_type { Fabricate(:visits_rule_type) }
end

Fabricator(:more_than_x_visits, from: :rule) do
  rule_type { Fabricate(:more_than_x_visits_rule_type) }
end

Fabricator(:less_than_x_visits, from: :rule) do
  rule_type { Fabricate(:less_than_x_visits_rule_type) }
end

Fabricator(:every_nth_visit, from: :rule) do
  rule_type { Fabricate(:every_nth_visit_rule_type) }
end

Fabricator(:ten_days_since_last_visit, from: :rule) do
  rule_type { Fabricate(:days_since_last_visit) }
  value "10"
end

Fabricator(:javascript_rule, from: :rule) do
  rule_type { Fabricate(:javascript_rule_type) }
end