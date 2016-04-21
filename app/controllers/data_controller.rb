class DataController < ApplicationController

  def index
    @start_date = Date.today.beginning_of_week
    @end_date = Date.today.end_of_week
  end

  def practice_export
    @start_date = Date.civil(params[:start_date][:year].to_i, params[:start_date][:month].to_i, params[:start_date][:day].to_i)
    @end_date = Date.civil(params[:end_date][:year].to_i, params[:end_date][:month].to_i, params[:end_date][:day].to_i)
    data = UserData.date_range_to_csv(@start_date, @end_date)

    file_name = "practice_data_#{Time.now.strftime('%F_%T').parameterize}.csv"
    tmp_output_path = File.join("/tmp", file_name)
    output_path = File.join(Rails.configuration.x.data_export_folder, file_name)


    begin
      system "touch #{tmp_output_path}"
      file = File.open(tmp_output_path, "w")
      file.write data
      file.close
      file = nil
      system "cp #{tmp_output_path} #{output_path}"
    rescue IOError => e
      # Error...
    ensure
      file.close unless file.nil?
    end

    flash.now[:practice] = "Practice data exported to:<br/>#{output_path}"
    render "index"

  end

  def research_export

    source_path = File.join(Dir.pwd, "db/production.sqlite3")
    file_name = "research_data_#{Time.now.strftime('%F_%T').parameterize}.sqlite3"
    output_path = File.join(Rails.configuration.x.data_export_folder, file_name)

    result = system("mkdir #{Rails.configuration.x.data_export_folder}")
    result = system("cp #{source_path} #{output_path}")

    flash.now[:research] = "Research data exported to:<br/>#{output_path}"
    render "index"
  end

end
