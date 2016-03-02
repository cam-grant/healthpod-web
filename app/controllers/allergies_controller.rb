class AllergiesController < ApplicationController

  def allergies
    if request.post?
      @user_data.update_attributes(user_data_params) unless params[:user_data].blank?
      session[:current_step] += 1

      if @user_data.has_other_allergies?
        session[:total_steps] += 1
        redirect_to other_allergies_url
      else
        redirect_to bmi_url
      end
    end
  end

  def other_allergies
    if request.post?
      @user_data.update_attributes(user_data_params) unless params[:user_data].blank?
      session[:current_step] += 1
      redirect_to bmi_url
    end
  end

end
