# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :envelope do
    message
    recipient

    trait :trashed do
      trash_flag true
    end

    trait :read do
      read_flag true
    end

    trait :deleted do
      delete_flag true
    end

    trait :week_ago do
      delivered_at 1.week.ago
    end

    trait :day_ago do
      delivered_at 1.day.ago
    end

    trait :hour_ago do
      delivered_at 1.hour.ago
    end

    factory :week_ago_envelope, traits: [:week_ago]
    factory :week_ago_read_envelope, traits: [:week_ago, :read]
    factory :week_ago_trashed_envelope, traits: [:week_ago, :trashed]
    factory :day_ago_envelope, traits: [:day_ago]
    factory :day_ago_read_envelope, traits: [:day_ago, :read]
    factory :day_ago_trashed_envelope, traits: [:day_ago, :trashed]
    factory :hour_ago_envelope, traits: [:hour_ago]
    factory :hour_ago_read_envelope, traits: [:hour_ago, :read]
    factory :hour_ago_trashed_envelope, traits: [:hour_ago, :trashed]

  end

end
