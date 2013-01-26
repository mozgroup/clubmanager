# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    organizer
    summary { Faker::Company.catch_phrase }
    description { Faker::Lorem.paragraph }
    starts_at_time 2.days.from_now
    starts_at_date 2.days.from_now
    ends_at_date 2.days.from_now
  end
end
