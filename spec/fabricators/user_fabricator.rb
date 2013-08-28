Fabricator(:user) do
  email "customer.user@example.com"
  password "123456"
  password_confirmation "123456"
  customer { Fabricate(:customer) }
  roles(count: 1) { Fabricate(:customer_user_role) }
end

Fabricator(:customer_admin, from: :user) do
  email "customer.admin@example.com"
  password "123456"
  password_confirmation "123456"
  customer { Fabricate(:customer) }
  roles(count: 1) { Fabricate(:customer_admin_role) }
end

Fabricator(:admin, from: :user) do
  email "admin@onserver360.se"
  password "123456"
  password_confirmation "123456"
  customer nil
  roles(count: 1) { Fabricate(:admin_role) }
end
