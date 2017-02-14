class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :new]
  def index
    @events = Event.all
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.user_id = current_user.id
    if @event.save
      flash[:success] = "Event created successfully!"
      redirect_to events_path
    else
      flash[:danger] = "There was an error creating the event."
      render :new
    end
  end

  def show
    @event = Event.find_by_id(params[:id])
    @comments = Comment.where(event_id: @event).order("created_at DESC")
  end
  private

  def event_params
    params.require(:event).permit(:user_id, :name, :description, :location, :type_of_sport, :date, :time, :duration, :minpax, :maxpax)
  end

end
