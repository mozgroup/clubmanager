# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :club_user, :class => 'ClubUsers' do
    user_id 1
    club_id 1
  end
end
