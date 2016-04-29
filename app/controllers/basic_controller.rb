class BasicController < ApplicationController

  def full_name
    session[:total_steps] = 9
    session[:current_step] = 1

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
    # Renders "Stand on the scales..." page
    # Page performs ajax call to BasicController#bmi_read
  end

  def bmi_read

    if Rails.configuration.x.enable_bmi_scales
      ReadBmiScalesJob.reset_scales
      ReadBmiScalesJob.perform_now @user_data
    else
      # Simulate pause while user uses scales...
      sleep 3

      # Set example data
      @user_data.weight = 75.6
      @user_data.height = 172
      @user_data.bmi = 24.5
      @user_data.bmi_recorded_at = Time.now
      @user_data.save
    end

    if @user_data.bmi.blank?
      render json: {}, status: 400
    elsif @user_data.height >= 198 # cm
      # BMI scales sometimes return bad height reading of 198cm - fail in this case...
      render json: {}, status: 400
    else
      session[:current_step] += 1
      render json: {
        weight: @user_data.weight,
        height: @user_data.height,
        bmi: @user_data.bmi
      }
    end
  end

  def has_diabetes
    if request.post?
      @user_data.update_attributes(user_data_params) unless params[:user_data].blank?
      @user_data.calc_basic_score
      redirect_to hub_url
    end
  end

end
