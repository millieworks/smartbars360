class TrackedUser < ActiveRecord::Base
  attr_accessible :customer_id, :public_user_id, :page_impressions, :visits

  validates_presence_of :customer_id
  validates_uniqueness_of :public_user_id

  before_create :generate_public_user_id

  def update_counters(visit_id)
    self.increment!(:page_impressions, 1)
    self.increment!(:visits, 1) if visit_id.blank?
  end

  private
  def generate_public_user_id
    begin
      self.public_user_id = SecureRandom.hex
    end while !self.class.where(public_user_id: public_user_id).empty?
  end
end
