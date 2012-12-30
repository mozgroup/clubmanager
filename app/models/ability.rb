class Ability
  include CanCan::Ability

  def initialize(user)

    if user.is_admin?
        can :manage, :all
    elsif user.is_manager? || user.is_owner?
        can :read, MonthlySummary
    end
            
  end
end
