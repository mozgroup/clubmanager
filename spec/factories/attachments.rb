# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :attachment do
    item "MyString"
    attachable_id 1
    attachable_type "MyString"
  end
end
