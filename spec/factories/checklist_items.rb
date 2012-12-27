# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :checklist_item do
    check_list_id 1
    name "MyString"
    due_on "MyString"
    complete_flg false
  end
end
