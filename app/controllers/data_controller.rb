class DataController < ApplicationController

  def index
    @start_date = Date.today.beginning_of_week
    @end_date = Date.today.end_of_week
  end

  def practice_export
    @start_date = Date.civil(params[:start_date][:year].to_i, params[:start_date][:month].to_i, params[:start_date][:day].to_i)
    @end_date = Date.civil(params[:end_date][:year].to_i, params[:end_date][:month].to_i, params[:end_date][:day].to_i)
    file_name = UserData.export_practice_data(@start_date, @end_date)
    flash.now[:practice] = "Practice data exported to <b>#{file_name}</b> (HealthPodData folder)"
    render "index"
  end

  def research_export
    file_name = UserData.export_research_data
    flash[:research] = "Research data exported to <b>#{file_name}</b> (HealthPodData folder)"
    redirect_to data_path
  end

  # Works, but not currently used...
  # def raw_db_copy
  #   source_path = File.join(Dir.pwd, "db/production.sqlite3")
  #   file_name = "research_data_#{Time.now.strftime('%F_%T').parameterize}.sqlite3"
  #   output_path = File.join(Rails.configuration.x.data_export_folder, file_name)
  #
  #   result = system("mkdir #{Rails.configuration.x.data_export_folder}")
  #   result = system("cp #{source_path} #{output_path}")
  #
  #   flash[:research] = "Database copied to <b>#{file_name}</b> (HealthPodData folder)"
  #   redirect_to data_path
  # end

end
