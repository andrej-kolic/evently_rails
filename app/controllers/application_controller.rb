class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception

  #protect_from_forgery with: :null_session


  def ping
    render json: {message: 'pong'}
  end

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def user_signed_in?
    current_user != nil
  end

  def authenticate_user!
    return if user_signed_in?

    respond_to do |format|
      format.html { redirect_to log_in_path, notice: 'Authentication required.' }
      format.json { render json: {}, status: :unprocessable_entity }
    end
  end

  helper_method :current_user, :authenticate!

end
