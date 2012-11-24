module EventsHelper
  def format_event_date(event_date)
    event_date.strftime('%A %B %-d, %Y at %l:%M %p')
  end
end
