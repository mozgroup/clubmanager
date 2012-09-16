# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :message do
    author
    subject "My Subject"
    body "The body of the message"
  end
end
