class UsersController < ApplicationController
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
      # just created the 'flash' obj, gave it a 'key' and a 'value'.
      flash[:success] = "Welcome to the Sample App!!"
      redirect_to @user  # to go to the new profile after correct submission.
      # the above is the same as:  redirect_to user_url(@user)
    else
      render 'new'
    end
  end

private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
