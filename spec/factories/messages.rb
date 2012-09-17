# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :message do
    author
    subject "My Subject"
    body "The body of the message"

    trait :sent do
      status Message::StatusSent
    end

    trait :week_ago do
      sent_at 1.week.ago
    end

    trait :hour_ago do
      sent_at 1.hour.ago
    end

    factory :sent_message, traits: [:sent]
    factory :sent_a_week_ago, traits: [:sent, :week_ago]
    factory :sent_an_hour_ago, traits: [:sent, :hour_ago]
  end
end
