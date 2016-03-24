class DiabetesController < ApplicationController

  def welcome
    session[:total_steps] = 1
    session[:current_step] = 1
  end

  def survey
    if request.post?
      @user_data.update_attributes(user_data_params) unless params[:user_data].blank?
      @user_data.update_attributes diabetes_complete: true
      redirect_to hub_url
    end
  end

end
