# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :envelope do
    message
    recipient
  end
end
