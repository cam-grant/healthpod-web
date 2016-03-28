class DiabetesController < ApplicationController

  def welcome
    session[:total_steps] = 7
    session[:current_step] = 1
  end

  def age_group
    if request.post?
      @user_data.update_attributes(user_data_params) unless params[:user_data].blank?
      session[:current_step] += 1
      redirect_to diabetes_hereditary_url
    end
  end

  def hereditary
    if request.post?
      @user_data.update_attributes(user_data_params) unless params[:user_data].blank?
      session[:current_step] += 1
      redirect_to diabetes_high_blood_glucose_url
    end
  end

  def high_blood_glucose
    if request.post?
      @user_data.update_attributes(user_data_params) unless params[:user_data].blank?
      session[:current_step] += 1
      redirect_to diabetes_hbp_medication_url
    end
  end

  def hbp_medication
    if request.post?
      @user_data.update_attributes(user_data_params) unless params[:user_data].blank?
      session[:current_step] += 1
      redirect_to diabetes_fruit_and_veg_url
    end
  end

  def fruit_and_veg
    if request.post?
      @user_data.update_attributes(user_data_params) unless params[:user_data].blank?
      session[:current_step] += 1
      redirect_to diabetes_physical_activity_url
    end
  end

  def physical_activity
    if request.post?
      @user_data.update_attributes(user_data_params) unless params[:user_data].blank?
      session[:current_step] += 1
      redirect_to diabetes_waist_measurement_url
    end
  end

  def waist_measurement
    if request.post?
      @user_data.update_attributes(user_data_params) unless params[:user_data].blank?
      @user_data.calc_diabetes_score
      redirect_to hub_url
    end
  end

end
