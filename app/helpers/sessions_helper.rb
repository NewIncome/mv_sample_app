module SessionsHelper

  #Logs in the given user.
  def log_in(user)
    session[:user_id] = user.id
  end

  # Remembers a user in a persistent session.
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  # Remembers a user in a persistent session.
  # THIS is only for better readability,...
  def current_user?(user)
    user == current_user
  end

  # Returns the current logged-in user (if any).
  def current_user
    if (user_id = session[:user_id])   # If session of user id exists... , and do the assignment
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  # Returns true if the user is logged in, false otherwise
  def logged_in?
    !current_user.nil?
  end

  # Forgets a persistent session
  def forget(user)
    user.forget   # puts the remember_digest to nil
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # Logs out the current user
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  # Redirects to stored location (or to the default).
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  # Stores the URL trying to be accessed.
  def store_location
    session[:forwarding_url] = request.original_url if request.get?
    # Here we use the 'request' object to get the originally requested URL.
  end
  # to use this accurately we need to add it in the logged_in_user method,
  # before filter. In the user#logged_in_user.
end