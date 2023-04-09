class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.try(:admin?)
      can :access, :rails_admin
      can :manage, :all
    else
      if user.farmer?
        can [:show, :new, :create, :edit, :update], Farmer, user_id: user.id
      end

      if user.general?
        can [:show, :new, :create, :edit, :update], General, user_id: user.id
        can :read, General, user_id: user.id
      end

      can :index, Farmer
      can :overview, Farmer
    end
  end
end