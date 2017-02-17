class FollowingsController < ApplicationController
  before_action :authenticate_user!
  def index
    @following_records = Following.where(user_id: current_user.id).select("follower_id")
    @people_following = User.where(id: @following_records).order(name: :desc)

  end

  def create

    @following = Following.new(user_id: current_user.id, follower_id: following_params[:follower_id])

    if @following.save
      flash[:success] = "Successfully followed!"
      redirect_to(:back)
    else
      flash[:danger] = "There was an error in following."
      redirect_to(:back)
    end
  end

  def destroy
    follow = Following.where(id: params[:id])[0]

    follow.destroy
    if follow.destroyed?
      flash[:success] = "successfully unfollowed!"
    else
      flash[:warning] = "failed to unfollow"
    end
    redirect_to(:back)
  end


  private

  def following_params
    params.require(:following).permit(:follower_id)
  end
end
