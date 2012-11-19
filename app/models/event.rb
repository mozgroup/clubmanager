class Event < ActiveRecord::Base
  attr_accessible :description, :end_at, :invitee_list, :location, :start_at, :subject, :user_id
end
