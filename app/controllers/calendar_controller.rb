class CalendarController < ApplicationController
  include CalendarMethods

  def index
    calendar_dates

    @events = current_user.events.for_month @current_date
  end
end
