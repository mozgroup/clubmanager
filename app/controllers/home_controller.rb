class HomeController < ApplicationController

  before_filter :authenticate_user!

  def index
  	@agenda_items = Agenda.find_by_date(Time.now, current_user)
  	@monthly_summary = MonthlySummary.for_club(current_user.default_club.id, Time.now.in_time_zone.beginning_of_month)[0]
  end
end
