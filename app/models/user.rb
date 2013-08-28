class User < ActiveRecord::Base
  devise :database_authenticatable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :customer_id, :role_ids

  validates_uniqueness_of :email
  validates_presence_of :email

  before_destroy :confirm_presence_of_last_admin_standing
  before_destroy { |user| user.roles.destroy_all }

  has_and_belongs_to_many :roles
  belongs_to :customer

  delegate :name, to: :customer, prefix: true

  scope :sorted, order: "email ASC"

  scope :admins, include: :roles, conditions: ["roles.name = ?", "Admin"]

  def admin?
    role?(:admin)
  end

  def role?(role)
    return !!self.roles.find_by_name(role.to_s.camelize)
  end

  def self.new_with_generated_password(user_params)
    user_params[:password] = user_params[:password_confirmation] = generated_password
    unless user_params[:customer_id].blank?
      user_params[:role_ids] = [ Role.find_by_name("CustomerUser").id ]
    else
      user_params[:role_ids] = [ Role.find_by_name("Admin").id ]
    end
    new(user_params)
  end

  def self.generated_password
    Devise.friendly_token.first(6)
  end

  protected
    def confirm_presence_of_last_admin_standing
      return true unless self.admin?
      unless User.admins.count > 1
        errors[:base] << "There must be at least one administrator"
        return false
      else
        return true
      end
    end
  end
