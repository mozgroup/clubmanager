# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :task do
    name { Faker::Company.bs }
    due_at 2.days.from_now
    context
    project
    owner
  end

  factory :assigned_task, parent: :task do
    assignee
    state 'assigned'
  end

  factory :claimed_task, parent: :task do
    assignee
    state 'claimed'
  end

  factory :started_task, parent: :task do
    assignee
    state 'started'
  end

end
