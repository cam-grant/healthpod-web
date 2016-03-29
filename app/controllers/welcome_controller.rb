class WelcomeController < ApplicationController

  def welcome
    reset_session
    @user_data = nil
  end

  def consent
    if request.post?
      consent = !params[:consent].blank?
      @user_data = UserData.new(consent: consent)
      @user_data.save

      if consent
        session[:user_data_id] = @user_data.id
        redirect_to hub_url # returning_user_url
      else
        redirect_to root_url
      end
    end
  end

  def hub
  end

  def print
  end

end
