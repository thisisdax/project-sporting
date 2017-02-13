class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  def index
    @events = Event.all
  end

  def new
    @event = Event.new
  end

  def create
    if user_signed_in?
      @event = Event.new(event_params)
      @event.user_id = current_user.id
      if @event.save
        flash[:success] = "Event created successfully!"
        redirect_to events_path
      else
        flash[:error] = "There was an error creating the event."
        render :new
      end
    else
      flash[:error] = "Please login to create an event!"
      redirect_to new_user_session_path
    end
  end

  private

  def event_params
    params.require(:event).permit(:user_id, :name, :description, :location, :type_of_sport, :date, :time, :duration, :minpax, :maxpax)
  end

end
