# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :club do
    name "MyString"
    region_id 1
    address "MyText"
  end
end
