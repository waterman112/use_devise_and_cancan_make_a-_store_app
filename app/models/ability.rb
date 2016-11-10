class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    # 所有的方法都是写在user.rb这个model内部，在这里被调用
       user ||= User.new # guest user (not logged in)
       if user.admin?
         can :manage, :all
       elsif user.seller?
         can :read, Item
         can :create, Item
         can :update, Item do |item|
           item.try(:user) == user
         end
         can :destroy, Item do |item|
           item.try(:user) == user
         end
       elsif user.regular?
         can :read, Item
       end
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
