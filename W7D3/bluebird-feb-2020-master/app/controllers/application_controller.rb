class ApplicationController < ActionController::Base
  # Disables CSRF protection
  # skip_before_action :verify_authenticity_token

  # gives views access to methods passed to helper_method
  helper_method :current_user, :logged_in?

  # methods written here are inherited by all of our controllers

  def login!(user)
    # session[:session_token] = user.session_token # session token never changes
    session[:session_token] = user.reset_session_token! # session token changes every login
  end

  def current_user
    # prevent unnecessary db query! no need to check if a user is logged in if the cookie is nil
    return nil unless session[:session_token]

    # find user in db whose session_token matches session[:session_token]
    # cache the value to optimize
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def logged_in?
    !!current_user 
  end

  def logout!
    # not this, no good
    # current_user.session_token = nil

    # adds entropy
    current_user.try(:reset_session_token!) # attempt to run this method, if fails catches error

    # nilify cookie session token
    session[:session_token] = nil

    # reset cached current user
    @current_user = nil
  end

  def require_logged_in!
    redirect_to new_session_url unless logged_in?
  end
end
