# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    user_id 1
    invitee_list "MyString"
    subject "MyString"
    location "MyString"
    description "MyText"
    start_at "2012-11-18 18:26:09"
    end_at "2012-11-18 18:26:09"
  end
end
