FactoryGirl.define do
  factory :user do
    employee_number '123456'
    first_name 'John'
    last_name 'doe'
    email
    password 'supersecret'
    password_confirmation 'supersecret'
  end

  sequence :email do |n|
    "person#{n}@email.com"
  end
end
