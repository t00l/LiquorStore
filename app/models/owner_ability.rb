class OwnerAbility
  include CanCan::Ability
  
  def initialize(owner)
    
    owner ||= Owner.new

    if owner.owner?
        can :read, :all
        can :create, [Store, Offer, Comment] #objeto
        can [:update, :delete], [Store, Offer, Comment], {owner_id: owner.id}
    else
        can :read, :all
    end

  end

end