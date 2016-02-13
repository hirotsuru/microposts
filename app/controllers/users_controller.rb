class UsersController < ApplicationController
  def show
   @user = User.find(params[:id])
   @microposts = @user.microposts.order(created_at: :desc)
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      flash[:alert] = "Signup failed"
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
    if logged_in? && current_user == @user
    else
      flash[:alert] = "Cannot update other user's profile!"
      redirect_to root_path
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:seccess] = "Successfully updated"
      redirect_to @user
    else
      flash[:alert] = "Updating Failed"
      render 'edit'
    end
  end
  
  def followings
    @user = User.find(params[:id])
    @users = @user.following_users
  end
  
  def followers
    @user = User.find(params[:id])
    @users = @user.follower_users
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation,
                                 :age, :location)
  end
end
