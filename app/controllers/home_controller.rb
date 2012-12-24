class HomeController < ApplicationController

  before_filter :authenticate_user!

  def index
  	@current_month = Time.now.in_time_zone.beginning_of_month
  	@clubs = Club.by_name
  	@agenda_items = Agenda.find_by_date(Time.now, current_user)
  end
end
