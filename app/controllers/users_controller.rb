class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show,:edit,:update]
  skip_before_action :verify_authenticity_token, :only => [:update]

  def index
    if current_user
      @users = User.where(["first_name LIKE ?", "%#{params[:search]}%"]).where.not(id: current_user.id)
      @users += User.where(["email LIKE ?", "%#{params[:search]}%"]).where.not(id: current_user.id)
      @users += User.where(["name LIKE ?", "%#{params[:search]}%"]).where.not(id: current_user.id)

      @usersfilter = @users.pluck(:id)
      @follow = Following.where(:follower_id => @usersfilter, :user_id => current_user.id) #produces an array of entries of people the current user is following
      @hash_of_follower_id_and_follow_id = Hash[@follow.map{ |c| [c.follower_id, c.id] }]
      @following = Following.new

    else
      @users = User.where(["first_name LIKE ?", "%#{params[:search]}%"])
      @users += User.where(["email LIKE ?", "%#{params[:search]}%"])
      @users += User.where(["name LIKE ?", "%#{params[:search]}%"])
      @not_signed_in = true
    end
    @events = Event.where(["name LIKE ?", "%#{params[:search]}%"])
    @events += Event.where(["description LIKE ?", "%#{params[:search]}%"])
  end
end

  def show

    @user = User.find_by_id(params[:id])
    #to see if truthie or falsie -> if current user already follow
    @follow = Following.where(:follower_id => params[:id], :user_id => current_user.id).first
    @following = Following.new

    current_following_records = @user.followings.select('follower_id')
    current_follower_records = Following.where(:follower_id => @user.id).select('user_id')

    @current_followings = User.where(:id => current_following_records)
    @current_followers = User.where(:id => current_follower_records)

    # render :show -> auto show by controller
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
