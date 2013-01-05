class Ability
  include CanCan::Ability

  def initialize(user)

    if user.is_admin?
        can :manage, :all
    elsif user.is_manager? || user.is_owner?
        can :read, MonthlySummary
        can :read, Checklist, user_id: user.id
        can [:read, :update], Checklist, author_id: user.id
        can :create, Checklist
        can :manage, Task, owner_id: user.id
        can [:read, :update], Task, assignee_id: user.id
        can [:read, :create], Context
        can [:read, :create], Project
    else
    	can :read, Checklist, user_id: user.id
      can [:read, :update], Task, assignee_id: user.id
    end
            
  end
end
