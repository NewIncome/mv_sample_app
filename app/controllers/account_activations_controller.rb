class AccountActivationsController < ApplicationController
  # it will get here because the link will be similar to:
  # https://rails-tutorial-mhartl.c9users.io/account_activations/
  # fFb_F94mgQtmlSvRFGsITw/edit?email=michael%40michaelhartl.com

  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate  # method in the model
      log_in user
      flash[:danger] = "Account succesfully activated!"
      redirect_to user
    else
      flash[:danger] = "Invalid activation link"
      redirect_to root_url
    end
  end
end