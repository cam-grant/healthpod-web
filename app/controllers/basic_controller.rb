class BasicController < ApplicationController

  def full_name
    if request.post?
      @user_data.update_attributes(user_data_params) unless params[:user_data].blank?
      session[:current_step] += 1
      redirect_to date_of_birth_and_gender_url
    end
  end

  def date_of_birth_and_gender
    if request.post?
      @user_data.update_attributes(user_data_params) unless params[:user_data].blank?
      session[:current_step] += 1
      redirect_to suburb_url
    end
  end

  def suburb
    if request.post?
      @user_data.update_attributes(user_data_params) unless params[:user_data].blank?
      session[:current_step] += 1
      redirect_to country_of_birth_url
    end
  end

  def country_of_birth
    if request.post?
      @user_data.update_attributes(user_data_params) unless params[:user_data].blank?
      session[:current_step] += 1
      redirect_to aboriginal_url
    end
  end

  def aboriginal
    if request.post?
      @user_data.update_attributes(user_data_params) unless params[:user_data].blank?
      session[:current_step] += 1
      redirect_to smoking_url
    end
  end

  def smoking
    if request.post?
      @user_data.update_attributes(user_data_params) unless params[:user_data].blank?
      session[:current_step] += 1
      redirect_to allergies_url
    end
  end

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

  def bmi
    # Render "Stand on the scales..." page
  end

  def bmi_read
    if Rails.env.production?
      ReadBmiScalesJob.reset_scales
      ReadBmiScalesJob.perform_now @user_data
    else
      # Simulate pause and data
      # sleep 5
      @user_data.update_attributes weight: 75.2, height: 175, bmi: 24.5, bmi_recorded_at: Time.now
    end

    if @user_data.bmi.blank?
      render :status => 400
    else
      session[:current_step] += 1
      render :json => {
        :weight => @user_data.weight,
        :height => @user_data.height,
        :bmi => @user_data.bmi
      }
    end
  end

  def has_diabetes
    if request.post?
      @user_data.update_attributes(user_data_params) unless params[:user_data].blank?
      @user_data.update_attributes basic_complete: true
      redirect_to hub_url
    end
  end

end
