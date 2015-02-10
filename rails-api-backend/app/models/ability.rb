class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.is? :moderator
      can :update, Gig
      can :unmoderated, Gig
    end
    can :update, Gig do |gig|
      # XXX if author of gig or owner of venue return true
      
      false
    end
  end
end
