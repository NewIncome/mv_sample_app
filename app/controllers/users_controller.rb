class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy] # requires the user be logged in
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy   # to enforce access control.

  def index
    @users = User.paginate(page: params[:page], per_page: 10) # can be used simple (page: params[:page])
    # that is with the default 30 elements per page.
  end

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
      @user.send_activation_email # method in the model
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
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

  def destroy
    User.find(params[:id]).destroy   # Here we chain the 'find' and 'destroy' methods
    flash[:success] = 'User deleted'
    redirect_to users_url
  end


private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  # Before filters
  # Confirms a loged-in user.
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

  # confirms the correct user is to edit his:only profile
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  # Confirms an admin user.
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
