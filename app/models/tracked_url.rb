class TrackedUrl < ActiveRecord::Base
  attr_accessible :host, :ip_address, :path, :port, :query, :scheme, :tracked_at, :tracked_user_id, :customer_id

  def self.add_tracked_user(url, customer_id, user_id, ip_address)
    url = URI(url)
    params = {
        tracked_user_id: user_id,
        customer_id: customer_id,
        ip_address: ip_address,
        scheme: url.scheme,
        host: url.host,
        port: url.port,
        path: url.path,
        query: url.query,
        tracked_at: Time.now
    }
    TrackedUrl.create(params)
  end
end
