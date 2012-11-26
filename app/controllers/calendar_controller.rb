class CalendarController < ApplicationController
  include CalendarMethods

  def index
    calendar_dates

    @events = Event.for_user(current_user.id).on(@current_date.at_beginning_of_month, @current_date.at_end_of_month)
  end
end
