class CalendarController < ApplicationController
  def index
    @current_date = params[:current_date] || Date.current
    @current_date = Date.parse(@current_date) unless @current_date.acts_like?(:date)
    @previous_month = @current_date.prev_month.to_formatted_s(:number)
    @next_month = @current_date.next_month.to_formatted_s(:number)
  end
end
