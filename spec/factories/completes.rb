# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :complete do
    completable_id 1
    completeable_type "MyString"
  end
end
