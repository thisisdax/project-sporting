class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :new]
  # before_action :list_attending, only: [:index]
  def index
    if current_user == nil
      if params[:date]
        @latestevents = Event.where("date >= ?", params[:date])
        @myevents = nil
      else
        @latestevents = Event.all
        @myevents = nil
      end
    else
      if params[:date]
        @latestevents = Event.all.where.not(user_id: current_user.id).where("date >= ?", params[:date])
      else
        @latestevents = Event.all.where.not(user_id: current_user.id)
      end
        @myevents = Event.all.where(user_id: current_user.id)
    end
    @events_by_date = @latestevents.group_by(&:date)
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.user_id = current_user.id
    if @event.save
      flash[:success] = "Event created successfully!"
      redirect_to join_event_path(@event.id)
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

  # def list_attending
  #   @list = Attending.find_by_user_id(current_user.id)
  # end
end
