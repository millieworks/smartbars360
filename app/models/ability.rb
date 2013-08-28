class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.role? :admin
      can :manage, :all
    elsif user.role? :customer_user
      can [:read, :update], User do |account|
        user == account
      end
      can :manage, Smartbar do |smartbar|
        smartbar.customer_id == user.customer_id
      end
    end
  end
end