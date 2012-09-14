# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :message do
    author
    send_to "MyString"
    copy_to "MyString"
    blind_copy_to "MyString"
    subject "My Subject"
    body "The body of the message"
  end
end
