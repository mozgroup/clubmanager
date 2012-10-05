# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :context do
    name { Faker::Company.bs }
    position 1

    owner
  end
end
