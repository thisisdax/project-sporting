class AttendingsController < ApplicationController
  before_action :join, only: [:redirection]
  before_action :authenticate_user!
  def join
    @attending = Attending.new
    @attending.event_id = params[:id]
    @attending.user_id = current_user.id
    if @attending.save
      flash[:success] = "Joined event successfully!"
      redirect_to events_path
    else
      flash[:danger] = "You have already joined the event."
      redirect_to events_path
    end
  end

  def leave
    @event = Event.find_by_id(params[:id])
    if @event.user_id == current_user.id
      if Attending.where(event_id: params[:id]).where.not(user_id: current_user.id).length == 0
        Event.find_by_id(params[:id]).destroy
      else
        @event.user_id = Attending.where(event_id: params[:id]).where.not(user_id: current_user.id).first.user_id
        Attending.where(event_id: params[:id]).find_by_user_id(current_user.id).destroy
      end
    end

    flash[:success] = "Left the event successfully!"
    redirect_to events_path
  end

  def redirection

  end

  def list
    @attending = Attending.find_by_user_id(current_user.id)
  end
end
