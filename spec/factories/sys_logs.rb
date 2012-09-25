# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :sys_log do
    message "MyText"
    message_type "MyString"
    actioned_by "MyString"
  end
end
