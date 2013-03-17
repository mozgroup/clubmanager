# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :checklist do
    user
    author
    name "A checklist"
    frequency "daily"
  end
end
