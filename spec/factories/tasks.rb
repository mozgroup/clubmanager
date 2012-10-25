# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :task do
    name { Faker::Company.bs }
    due_at 2.days.from_now
    context
    project
    owner
    assignee
  end
end
