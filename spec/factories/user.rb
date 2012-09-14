FactoryGirl.define do
  factory :user, aliases: [:author, :recipient] do
    employee_number '123456'
    first_name 'John'
    last_name 'doe'
    title 'manager'
    email
    password 'supersecret'
    password_confirmation 'supersecret'
  end

  sequence :email do |n|
    "person#{n}@email.com"
  end
end
