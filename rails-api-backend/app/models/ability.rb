class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.is? :moderator
      can :update, Gig
      can :unmoderated, Gig
    end
  end
end
