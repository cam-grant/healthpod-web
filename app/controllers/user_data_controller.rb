class UserDataController < ApplicationController

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
    if request.post?
      @user_data.update_attributes(user_data_params) unless params[:user_data].blank?
      redirect_to bmi_url
    end
  end

  def full_name

  end

  def bmi
    # Render "Stand on the scales..." screen
  end

  def bmi_read
    ReadBmiScalesJob.reset_scales
    ReadBmiScalesJob.perform_now @user_data

    if @user_data.bmi.blank?
      render :status => 400
    else
      render :json => {
        :weight => @user_data.weight,
        :height => @user_data.height,
        :bmi => @user_data.bmi
      }
    end
  end

private

  def user_data_params
    params.require(:user_data).permit!
  end

end
