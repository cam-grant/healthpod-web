class DemographicsController < ApplicationController

  def full_name
    if request.post?
      @user_data.update_attributes(user_data_params) unless params[:user_data].blank?
      redirect_to date_of_birth_and_gender_url
    end
  end

  def date_of_birth_and_gender
    if request.post?
      @user_data.update_attributes(user_data_params) unless params[:user_data].blank?
      redirect_to suburb_url
    end
  end

  def suburb
    if request.post?
      @user_data.update_attributes(user_data_params) unless params[:user_data].blank?
      redirect_to country_of_birth_url
    end
  end

  def country_of_birth
    if request.post?
      @user_data.update_attributes(user_data_params) unless params[:user_data].blank?
      redirect_to ethnicity_url
    end
  end

  def ethnicity
    if request.post?
      @user_data.update_attributes(user_data_params) unless params[:user_data].blank?
      redirect_to diabetes_url
    end
  end

  def diabetes
    if request.post?
      @user_data.update_attributes(user_data_params) unless params[:user_data].blank?
      redirect_to allergies_path
    end
  end

end
