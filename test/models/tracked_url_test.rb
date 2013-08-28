require "minitest_helper"

describe TrackedUrl do
  include TransactionalTestHelpers

  it "must add tracked user" do
    turl = TrackedUrl.add_tracked_user("http://example.com:8080/path?query=query", "customer_id", "tracked_user_id", "127.0.0.1")
    turl.scheme.must_equal "http"
    turl.host.must_equal "example.com"
    turl.port.must_equal 8080
    turl.path.must_equal "/path"
    turl.query.must_equal "query=query"
    turl.ip_address.must_equal "127.0.0.1"
    turl.customer_id.must_equal "customer_id"
    turl.tracked_user_id.must_equal "tracked_user_id"
  end

end
