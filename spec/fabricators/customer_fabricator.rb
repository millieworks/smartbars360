Fabricator(:customer) do
  name "Test customer"
  api_key "abc123"
end

Fabricator(:demo_application, from: :customer) do
  name "Demo Application"
  api_key "demo_application_api_key"
end
