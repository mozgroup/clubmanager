class CalendarController < ApplicationController
  def index
    @current_date = params[:current_date] || Time.zone.now
    @current_date = Time.zone.parse(@current_date) unless @current_date.acts_like?(:time)
    @previous_month = @current_date.prev_month.to_formatted_s(:number)
    @next_month = @current_date.next_month.to_formatted_s(:number)
    @events = current_user.events.for_month @current_date
  end
end
