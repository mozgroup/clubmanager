FactoryGirl.define do
  factory :user, aliases: [:author, :recipient, :owner, :assignee, :organizer] do
    employee_number
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    title { Faker::Name.title }
    email
    password 'supersecret'
    password_confirmation 'supersecret'
  end

  sequence :email do |n|
    "person#{n}@email.com"
  end

  sequence :employee_number do |n|
    "100#{n}"
  end
end
