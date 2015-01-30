class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.is? :moderator
      can :moderate, Gig
      can :update, Gig

      can :create, Venue
      
    else
      can :read, Gig
    end
  end
end
