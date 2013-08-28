class CreateTrackedUrls < ActiveRecord::Migration
  def change
    create_table :tracked_urls do |t|
      t.string :tracked_user_id
      t.string :customer_id
      t.string :ip_address
      t.string :scheme
      t.string :host
      t.string :port
      t.string :path
      t.string :query
      t.datetime :tracked_at

      t.timestamps
    end

    add_index :tracked_urls, :tracked_user_id
    add_index :tracked_urls, :customer_id
    add_index :tracked_urls, :tracked_at
  end
end
