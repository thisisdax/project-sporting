class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :new, :recommend, :myevents]
  # before_action :list_attending, only: [:index]
  def index
    if current_user == nil
      if params[:date]
        @latestevents = Event.where("date >= ?", params[:date]).first(4)
        @myevents = nil
      else
        @latestevents = Event.all.order('created_at DESC').first(4)
        @myevents = nil
      end
    else
      if params[:date]
        @latestevents = Event.all.where.not(user_id: current_user.id).where("date >= ?", params[:date]).order('created_at DESC').first(4)
      elsif params[:region]
        puts "YESSSSSSSSSSSSSSSSSSKTKEPOOSDJBSB"
        @latestevents = Event.where("region = ?", params[:region])
      else
        @latestevents = Event.all.where.not(user_id: current_user.id).order('created_at DESC').first(4)
      end
        @myevents = Event.all.where(user_id: current_user.id).order('created_at DESC').first(4)
    end
    @events_by_date = @latestevents.group_by(&:date)
    @date = params[:datedisplay] ? Date.parse(params[:datedisplay]) : Date.today
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.user_id = current_user.id

    if @event.save
      EventTag.create(tag_id: @event.region, event_id: @event.id)
      EventTag.create(tag_id: @event.location, event_id: @event.id)
      EventTag.create(tag_id: @event.type_of_sport, event_id: @event.id)
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

  def list
    if current_user == nil
      @event = Event.all.order('created_at DESC')
      @check = 1
    else
      @event = Event.all.where.not(user_id: current_user.id).order('created_at DESC')
      @check = 1
    end
    @tag = Tag.all

  end

  def recommend
    @filter = Attending.all.where(user_id: current_user.id).select(:event_id).pluck(:event_id)
    @follow = Following.all.where(user_id: current_user.id).select(:follower_id)
    @recommend = Attending.all.where(user_id: @follow).select(:event_id)
    @event = Event.all.where.not(user_id: current_user.id, id: @filter).where(id: @recommend).order('created_at DESC')
    @tag = Tag.all
    @check = 2
    render :list

  end

  def myevents
    @event = Event.all.where(user_id: current_user.id)
    @tag = Tag.all
    @check = 3
    render :list

  end

  private

  def event_params
    params.require(:event).permit(:user_id, :name, :description, :region, :location, :type_of_sport, :date, :time, :duration, :minpax, :maxpax)
  end

  # def list_attending
  #   @list = Attending.find_by_user_id(current_user.id)
  # end
end
