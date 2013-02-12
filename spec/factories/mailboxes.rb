# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :mailbox do
    user
    name "MyString"
    host "MyString"
    port "MyString"
    ssl false
    domain "MyString"
    username "MyString"
    password_digest "MyString"
    starttls_auto false
  end
end
