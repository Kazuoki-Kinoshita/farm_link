class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.try(:admin?)
      can :access, :rails_admin
      can :manage, :all
    else
      if user.farmer? && user.farmer.present?
        can :manage, Farmer, user_id: user.id
        can :manage, Experience, farmer_id: user.farmer.id
        can :manage, Schedule, experience: { farmer_id: user.farmer.id }
        can :manage, Post, farmer_id: user.farmer.id
        can :manage, Plot, farmer_id: user.farmer.id
      elsif user.farmer? && user.farmer.nil?
        can :create, Farmer, user_id: user.id 
      end

      if user.general? && user.general.present?
        can :manage, General, user_id: user.id 
      elsif user.general? && user.general.nil?
        can :create, General, user_id: user.id
      end

    end
    can :manage, User, id: user.id
    can :read, Farmer
    can :overview, Farmer
    can :read, Experience
    can :read, General
    can :read, Post   
  end
end