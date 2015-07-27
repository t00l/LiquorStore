class Ability
  include CanCan::Ability

  def initialize(user)
       
    user ||= User.new

    if user.moderator?
        can :manage, :all

    elsif user.guest?
        can :read, :all
        can :create, [Store, Offer] #objeto
        can [:edit, :delete], [Store], user_id: user.id   
        can [:delete], [Offer], user_id: user.id 
        #lo ultimo dice que el userid tiene que ser igual al current user
    else
        can :read, :all
    end

  end

end
