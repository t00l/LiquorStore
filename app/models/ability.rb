class UserAbility
  include CanCan::Ability

  def initialize(user)
    
    user ||= User.new

    if user.guest?
        can :read, :all
        can :create, Comment #objeto
        can [:update, :delete], Comment, {user_id: user.id}
    elsif user.moderator?
        can :manage, :all
    else
        can :read, :all
    end

  end

end

class OwnerAbility
  include CanCan::Ability
  
  def initialize(owner)
    
    owner ||= Owner.new

    if owner.owner?
        can :read, :all
        can :create, [Store, Offer, Comment] #objeto
        can [:update, :delete], [Store, Offer, Comment], {user_id: user.id}
    else
        can :read, :all
    end

    can :create_store_product, Store

  end

end
