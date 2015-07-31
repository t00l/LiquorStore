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