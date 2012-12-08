class HomeController < ApplicationController

  before_filter :authenticate_user!

  def index
  	@agenda_items = Agenda.find_by_date(Time.now, current_user)
  end
end
