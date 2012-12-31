class HomeController < ApplicationController

  before_filter :authenticate_user!
  before_filter :get_layout_data

  def index
  	@current_month = Time.now.in_time_zone.beginning_of_month
  	@clubs = current_user.clubs
  	@agenda_items = Agenda.find_by_date(Time.now, current_user)
  	@current_date = Time.now.in_time_zone.beginning_of_day
  end
end
