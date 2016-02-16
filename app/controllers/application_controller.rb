class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_user_data

protected

  def set_user_data
    unless session[:user_data_id].nil? || !UserData.exists?(session[:user_data_id])
      @user_data = UserData.find(session[:user_data_id])
    end
  end

end
