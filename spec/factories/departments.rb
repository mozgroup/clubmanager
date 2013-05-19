# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :department do
    manager
    name "MyString"
    description "MyText"
  end
end
