class Ability
  include CanCan::Ability

  def initialize(user)
    
    user ||= User.new

    if user.guest?
        can :read, :all
        can :create, [Store, Offer] #objeto
        can :delete, Offer, {user_id: user.id}
        can [:update, :delete], Store, {user_id: user.id}
    elsif user.moderator?
        can :manage, :all
    else
        can :read, :all
    end

  end

end
