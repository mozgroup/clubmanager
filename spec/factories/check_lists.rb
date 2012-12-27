# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :check_list do
    user_id 1
    name "MyString"
    frequency "MyString"
  end
end
