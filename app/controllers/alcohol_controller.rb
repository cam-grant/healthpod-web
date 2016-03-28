class AlcoholController < ApplicationController

  def welcome
    session[:total_steps] = 3
    session[:current_step] = 1
  end

  def frequency
    if request.post?
      @user_data.update_attributes(user_data_params) unless params[:user_data].blank?

      if @user_data.non_drinker?
        @user_data.calc_alcohol_score
        redirect_to hub_url
      else
        session[:current_step] += 1
        redirect_to alcohol_num_drinks_url
      end
    end
  end

  def num_drinks
    if request.post?
      @user_data.update_attributes(user_data_params) unless params[:user_data].blank?
      session[:current_step] += 1
      redirect_to alcohol_frequency_six_or_more_url
    end
  end

  def frequency_six_or_more
    if request.post?
      @user_data.update_attributes(user_data_params) unless params[:user_data].blank?
      @user_data.calc_alcohol_score
      redirect_to hub_url
    end
  end

end
