class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update] # requires the user be logged in
  before_action :correct_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    # debugger. Adds a debugger in the Rails Server
    # for the chosen View.
  end

  def new
    # now we'll start making new users.
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # to log in the user immediately after signing up.
      log_in @user
      # just created the 'flash' obj, gave it a 'key' and a 'value'.
      flash[:success] = "Welcome to the Sample App!!"
      redirect_to @user  # to go to the new profile after correct submission.
      # the above is the same as:  redirect_to user_url(@user)
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params) #to prevent mass assignment vulnerability
      flash[:success] = 'Profile updated'
      redirect_to @user
    else
      render 'edit'
    end
  end


private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  # Before filters
  # Confirms a loged-in user.
  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

  # confirms the correct user is to edit his:only profile
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless @user == current_user
  end
end
