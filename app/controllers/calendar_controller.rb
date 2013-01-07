class CalendarController < ApplicationController
  before_filter :authenticate_user!
  before_filter :get_layout_data

  include CalendarMethods

  def index
    calendar_dates

    @events = current_user.events.for_month @current_date
  end
end
