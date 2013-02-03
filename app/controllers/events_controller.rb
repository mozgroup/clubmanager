class EventsController < ApplicationController
  include CalendarMethods

  layout false

  def new
    @current_date = params[:current_date]
    @event = Event.new(organizer_id: current_user.id, starts_at_date: event_date(@current_date), ends_at_date: event_date(@current_date))
  end

  def edit
    @event = Event.find params[:id]
    @current_date = @event.starts_at_date
  end

  def create
    @event = Event.new(params[:event])
    if @event.save
      flash[:success] = "Event created!"
      calendar_dates
    else
      render 'new'
    end
  end

  def update
    @event = Event.find params[:id]
    if @event.update_attributes(params[:event])
      flash[:success] = "Event updated"
      calendar_dates
      @events = current_user.events.for_month @current_date
      render 'ifshow'
    else
      render 'new'
    end
  end

  def show
    @event = Event.find params[:id]
  end

  def destroy
    event = Event.find params[:id]
    event.destroy
    render :nothing => true
  end

  private

    def event_date(current_date = Time.zone.now)
      date = current_date.acts_like?(:time) ? current_date : Time.zone.parse(current_date)
      date.strftime('%A, %B %-d, %Y')
    end
end
