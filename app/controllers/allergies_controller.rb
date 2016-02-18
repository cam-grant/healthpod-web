class AllergiesController < ApplicationController

  def has_allergies
    if request.post?
      @user_data.update_attributes(user_data_params) unless params[:user_data].blank?
      session[:current_step] += 1

      if @user_data.has_allergies
        session[:total_steps] += 1
        redirect_to allergy_list_url
      else
        redirect_to bmi_url
      end
    end
  end

  def allergy_list
    if request.post?
      @user_data.update_attributes(user_data_params) unless params[:user_data].blank?
      session[:current_step] += 1
      redirect_to bmi_url
    end
  end

end
