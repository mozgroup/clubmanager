class EventsController < ApplicationController
  include CalendarMethods

  layout false

  def new
    @current_date = params[:current_date]
    @event = Event.new(user_id: current_user.id, start_at: event_time(1.hour, @current_date), end_at: event_time(90.minutes, @current_date))
  end

  def edit
    @event = Event.find params[:id]
    @current_date = @event.start_at
  end

  def create
    @event = Event.new(params[:event])
    if @event.save
      @event.send_invite
      flash[:success] = "Event created!"
      calendar_dates
      @events = current_user.events.for_month @current_date
      render 'ifshow'
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

    def event_time(offset, current_date = Time.zone.now)
      date = current_date.acts_like?(:time) ? current_date : Time.parse(current_date)
      time = Time.zone.now.beginning_of_hour + offset
      Time.new(date.year,date.month,date.day,time.hour,time.min)
    end
end
