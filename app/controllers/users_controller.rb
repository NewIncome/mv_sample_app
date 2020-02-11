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
      #Handle a successful save.
    else
      render 'new'
    end
  end
end
