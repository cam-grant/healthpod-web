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
        redirect_to returning_user_url
      else
        redirect_to root_url
      end
    end
  end

  def returning_user
    session[:total_steps] = 9
    session[:current_step] = 1
    if request.post?
      @user_data.update_attributes(user_data_params) unless params[:user_data].blank?
      session[:current_step] += 1
      redirect_to full_name_url
    end
  end

  def hub
  end

  def print
  end

end
