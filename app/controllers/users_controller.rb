class UsersController < ApplicationController
  before_action :authenticate_user, only: [:edit, :update]
      
  def show
   @user = User.find(params[:id])
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
  end

  def update
    if @user.update(user_params)
      flash[:seccess] = "Successfully updated"
      redirect_to @user
    else
      flash[:alert] = "Updating Failed"
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation,
                                 :age, :location)
  end
  
  def authenticate_user
    @user = User.find(params[:id])
    if logged_in? && current_user == @user
    else
      flash[:alert] = "Cannot update other user's profile!"
      redirect_to root_path
    end
  end
  
end
