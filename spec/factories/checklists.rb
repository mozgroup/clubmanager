# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :checklist do
    user
    author
    name "A checklist"
    frequency "daily"
  end

  factory :checklist_child, class: Checklist do
    user
    author
    name "A child checklist"
    frequency "daily"
    checklist_item
  end
end
