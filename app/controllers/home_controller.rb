class HomeController < ApplicationController

  before_filter :authenticate_user!
  before_filter :get_layout_data

  def index
    @current_month = Time.zone.now.beginning_of_month
    @clubs = current_user.clubs
    @agenda_items = Agenda.find_by_date(Time.zone.now, current_user)
    @current_date = Time.zone.now.beginning_of_day
  end
end
