class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show,:edit, :update]
  skip_before_action :verify_authenticity_token, :only => [:update]
  def show
    @user = User.find_by_id(params[:id])
    #to see if truthie or falsie -> if current user already follow
    @follow = Following.where(:follower_id => params[:id], :user_id => current_user.id).first
    @following = Following.new
    # render :show
  end

  def edit
    @user = User.find(current_user.id)
    render :edit
  end

  def update
   @user = User.find(current_user.id)
   name = user_params["name"]
   value = user_params["value"]
   @user.update(name => value)

    if @user.save
     flash[:success] = "user successfully updated!"
    else
      flash[:warning] = "user failed to update!"
    end
    redirect_to users_profile_edit_path
  end

  def update_image
    @user = User.find(current_user.id)
    image = Cloudinary::Uploader.upload(image_params["image"])
    @user.update("image" => image["url"])
    if @user.save
      flash[:success] = "user profile picture updated!"
    else
      flash[:warning] = "user picture failed to update!"
    end
    redirect_to users_profile_edit_path
  end

  private
  def user_params
    params.permit(:name,:value,:pk)
  end

  def image_params
    params["user"]
  end

end
