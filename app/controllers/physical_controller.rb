class PhysicalController < ApplicationController

  def welcome
    session[:total_steps] = 7
    session[:current_step] = 1
  end

  def work_type
    if request.post?
      @user_data.update_attributes(user_data_params) unless params[:user_data].blank?
      session[:current_step] += 1
      redirect_to physical_activity_exercise_url
    end
  end

  def activity_exercise
    if request.post?
      @user_data.update_attributes(user_data_params) unless params[:user_data].blank?
      session[:current_step] += 1
      redirect_to physical_activity_cycling_url
    end
  end

  def activity_cycling
    if request.post?
      @user_data.update_attributes(user_data_params) unless params[:user_data].blank?
      @user_data.calc_physical_score
      redirect_to physical_activity_walking_url
    end
  end

  def activity_walking
    if request.post?
      @user_data.update_attributes(user_data_params) unless params[:user_data].blank?
      session[:current_step] += 1
      redirect_to physical_activity_housework_url
    end
  end

  def activity_housework
    if request.post?
      @user_data.update_attributes(user_data_params) unless params[:user_data].blank?
      session[:current_step] += 1
      redirect_to physical_activity_gardening_url
    end
  end

  def activity_gardening
    if request.post?
      @user_data.update_attributes(user_data_params) unless params[:user_data].blank?
      session[:current_step] += 1
      redirect_to physical_walking_pace_url
    end
  end

  def walking_pace
    if request.post?
      @user_data.update_attributes(user_data_params) unless params[:user_data].blank?
      @user_data.calc_physical_score
      redirect_to hub_url
    end
  end

end
