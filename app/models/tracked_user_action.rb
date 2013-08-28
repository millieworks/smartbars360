class TrackedUserActionValidator < ActiveModel::Validator
  def validate(record)
    smartbar = Smartbar.find(record.smartbar_id)
    tracked_user = TrackedUser.find(record.tracked_user_id)
    unless smartbar.customer_id == tracked_user.customer_id
      record.errors[:base] << 'Customer ids for tracked user and smartbar do not match'
    end
  end
end

class TrackedUserAction < ActiveRecord::Base
  attr_accessible :smartbar_id, :tracked_user_id, :data

  belongs_to :smartbar

  validates_with TrackedUserActionValidator

  def self.get_smartbars_with_data(current_user_id)
    TrackedUserAction.connection.select_all(%Q(SELECT DISTINCT
          tracked_user_actions.smartbar_id,
          smartbars.name
        FROM
          tracked_user_actions,
	        smartbars,
          users
        WHERE
          tracked_user_actions.smartbar_id = smartbars.id
        AND smartbars.customer_id = users.customer_id
        AND users.id = #{current_user_id}
        AND tracked_user_actions.data IS NOT NULL
        ORDER BY
          smartbars.name ASC))
  end

  def self.get_csv_data(current_user_id, smartbar_id)
    download_data = TrackedUserAction.connection.select_all(%Q(SELECT
	        tracked_user_actions.data,
	        tracked_user_actions.created_at
        FROM
	        tracked_user_actions,
	        smartbars,
          users
        WHERE
	        tracked_user_actions.smartbar_id = smartbars.id
        AND smartbars.customer_id = users.customer_id
        AND users.id = #{current_user_id}
        AND smartbars.id = #{smartbar_id}
        AND tracked_user_actions.data IS NOT NULL
        ORDER BY
          tracked_user_actions.smartbar_id ASC))

    keys = download_data.collect { |row| YAML::load(row["data"]).keys.each { |k| k.to_s } }.flatten.compact.collect { |key| URI.unescape(key) }.uniq.sort
    csv_data = keys.join(",") + ",tracked_at\n"
    download_data.each do |row|
      data = YAML::load(row["data"])
      keys.each do |key|
        data_point = data[key].nil? ? '' : URI.unescape(data[key])
        csv_data << data_point + ","
      end
      csv_data << row["created_at"] + "\n"
    end
    csv_data
  end

  def self.create_from_tracked_user_public_id_and_smartbar(tracked_user_public_id, smartbar, data = nil)
    tracked_user = TrackedUser.find_by_public_user_id(tracked_user_public_id)
    tracked_user_action = new(tracked_user_id: tracked_user.id, smartbar_id: smartbar.id, data: data)
    if tracked_user_action.save
      smartbar.delay.issue_callback(tracked_user_public_id, tracked_user_action.data)
    else
      logger.warn "Tracked user action not created"
    end
  end
end
