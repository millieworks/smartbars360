Fabricator(:tracked_user) do
  public_user_id "MyString"
  customer_id 1
  page_impressions 0
  visits 0
end

Fabricator(:first_time_visitor, from: :tracked_user) do
  page_impressions 1
  visits 1
end

Fabricator(:return_visitor, from: :tracked_user) do
  page_impressions 2
  visits 2
end

Fabricator(:recent_visitor, from: :tracked_user) do
  updated_at Time.now - 3.days
end

Fabricator(:earlier_visitor, from: :tracked_user) do
  updated_at Time.now - 3.months
end
