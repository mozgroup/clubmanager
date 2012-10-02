# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :context do
    name "A context"
    position 1

    owner
  end
end
