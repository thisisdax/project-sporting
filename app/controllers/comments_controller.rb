class CommentsController < ApplicationController
  before_action :find_event
  before_action :find_comment, only: [:destroy, :edit, :update, :comment_owner]
  before_action :comment_owner, only: [:destroy, :edit, :update]

  def create
    @comment = @event.comments.create(params[:comment].permit(:message))
    @comment.user_id = current_user.id
    @comment.save
    if @comment.save
      redirect_to event_path(@event)
    else
      render 'new'
    end
  end

  def destroy
    @comment.destroy
    redirect_to event_path(@event)
  end

  def edit

  end

  def update
    if @comment.update(params[:comment].permit(:message))
      redirect_to event_path(@event)
    else
      render 'edit'
    end
  end

  private

  def find_event
    @event = Event.find(params[:event_id])
  end

  def find_comment
    @comment = @event.comments.find(params[:id])
  end

  def comment_owner
    unless current_user.id == @comment.user_id
      flash[:notice] = "You have no access"
      redirect_to @event
    end
  end
end
