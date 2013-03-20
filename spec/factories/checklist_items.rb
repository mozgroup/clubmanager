# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :checklist_item do
    checklist
    name "Checklist Item"
  end
end
