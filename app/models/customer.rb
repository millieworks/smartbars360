class Customer < ActiveRecord::Base
  attr_accessible :name

  has_many :users, dependent: :destroy
  has_many :smartbars, dependent: :destroy

  validates_presence_of :name
  validates_uniqueness_of :api_key

  before_create :generate_api_key

  scope :sorted, order: "name ASC"

  private
    def generate_api_key
      begin
        self.api_key = SecureRandom.hex
      end while !self.class.where(api_key: api_key).empty?
    end
end
