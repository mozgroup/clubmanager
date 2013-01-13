class Ability
  include CanCan::Ability

  def initialize(user)

    if user.is_admin?
      can :manage, :all
    elsif user.is_manager? || user.is_owner?
      can :read, MonthlySummary
      # Checklists
      can :read, Checklist, user_id: user.id
      can [:read, :update], Checklist, author_id: user.id
      can :create, Checklist
      can [:read, :update], Task, assignee_id: user.id
      # Tasks
      can :manage, Task, owner_id: user.id
      can [:read, :create], Context
      can [:read, :create], Project
      can [:create, :read], Event
      can [:update, :destroy], Event, user_id: user.id
      can :search, User
      can [:read, :update, :change_password], User, id: user.id
    else
      can :read, Checklist, user_id: user.id
      can :read, Task, assignee_id: user.id
      can [:update_claimed, :start, :complete], Task, assignee_id: user.id
      can :search, User
      can [:read, :update, :change_password], User, id: user.id
    end

  end
end
