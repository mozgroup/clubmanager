class EventObserver < ActiveRecord::Observer
  def after_create(event)
    Notifier::Events.deliver_invitation event unless event.invitee_list.blank?
  end
end
