class WelcomeController < ApplicationController

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
      if @user_data.returning_user
        redirect_to returning_user_q1_url
      else
        redirect_to hub_url
      end
    end
  end

  # Likert
  def returning_user_q1
    if request.post?
      @user_data.update_attributes(user_data_params) unless params[:user_data].blank?
      redirect_to returning_user_q2_url
    end
  end

  # Did you discuss any health issues identified on your health report card with your GP, nurse, friends or family?
  def returning_user_q2
    if request.post?
      @user_data.update_attributes(user_data_params) unless params[:user_data].blank?
      redirect_to returning_user_q3_url
    end
  end

  # Did you do any of the following after using the Health Pod?
  def returning_user_q3
    if request.post?
      @user_data.update_attributes(user_data_params) unless params[:user_data].blank?
      if @user_data.returning_user_took_other_steps?
        redirect_to returning_user_q4_url
      else
        redirect_to returning_user_q5_url
      end
    end
  end

  # Other steps taken after using the Health Pod
  def returning_user_q4
    if request.post?
      @user_data.update_attributes(user_data_params) unless params[:user_data].blank?
      redirect_to returning_user_q5_url
    end
  end

  # Did you visit the website shown on your health report card?
  def returning_user_q5
    if request.post?
      @user_data.update_attributes(user_data_params) unless params[:user_data].blank?
      redirect_to hub_url
    end
  end

  def hub
  end

  def print
    report = ReportCard.new(@user_data)
    report.generate
    result = system("lp -d \"#{Rails.configuration.x.printer_name}\" -o media=A5 #{report.file_path}")
    unless result
      logger.error "Error printing health report card: #{result}"
    end
  end

  def follow_up
    if request.post?
      @user_data.update_attributes(user_data_params) unless params[:user_data].blank?
      render "welcome/follow_up_done"
    end
  end

end
