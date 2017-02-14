class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :new]
  def index
    if params[:date]
      @events = Event.where("date >= ?", params[:date])
    else
      @events = Event.all
    end
    # @events = Event.all
    @events_by_date = @events.group_by(&:date)
    # ^ this will generate a hash with a key as the date of event
    # @events.each_with_index do | value, index |
    #   puts "*************value"
    #   puts "#{value.date}"
    #   if (params[:date].to_time <= value.date)
    #     puts "show this event"
    #   else
    #     puts "hide this event"
    #   end
    # end
      # if (params[:year].to_i < value.date.year)
      #   puts "show this event"
      # elsif (params[:year].to_i == value.date.year) && (params[:month].to_i < value.date.month)
      #   puts "show this event"
      # elsif (params[:year].to_i == value.date.year) && (params[:month].to_i == value.date.month) && (params[:day].to_i <= value.date.day)
      #   puts "show this event"
      # else
      #   puts "hide this event"
      # end
      # puts "#{value.date}"
      # # puts "#{value.date.month.inspect}"
      # # puts "#{value.date.day.inspect}"
      # puts "*************"
      # puts "*************index"
      # puts "#{index}"
      # puts "*************"
    # end
    # puts "*************params[:date]"
    # puts "#{params[:date]}"
    # puts "*************"
    # puts "************* to_time"
    # puts "#{params[:date].to_time.strftime('%Y-%m-%d')}"
    # puts "*************"
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
