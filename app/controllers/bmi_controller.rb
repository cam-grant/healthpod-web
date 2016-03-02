class BmiController < ApplicationController

  def bmi
    @current_step = 9
    # Render "Stand on the scales..." screen
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

      @user_data.update_attributes basic_complete: true

      render :json => {
        :weight => @user_data.weight,
        :height => @user_data.height,
        :bmi => @user_data.bmi
      }
    end
  end

end
