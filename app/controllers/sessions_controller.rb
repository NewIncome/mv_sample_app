class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        # params[:session][:remember_me] is where the value of the checkbox is stored.
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        # redirect_to user   # same as-->  user_url(user)
        redirect_back_or user
        # above line commented to redirecto_back_or for Friendly-Forwarding
      else
        message = "Account not activated. "
        message += "Check your email for the activation link."
        flash.now[:warning] = message
        redirect_to root_url
      end
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
