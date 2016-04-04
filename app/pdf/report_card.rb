require 'prawn'

class ReportCard

  attr_accessor :file_path

  def initialize(user_data)
    @user_data = user_data
    @file_path = File.join(Rails.configuration.x.reports_folder, "health_report_#{@user_data.id}.pdf")
  end

  def generate
    image_path = "#{Rails.root}/app/assets/images/pdf"
    font_name = "Helvetica"
    font_size = 7
    font_color = "000000"
    large_font_size = 22
    box_width = 150
    margin = 10

    pdf = Prawn::Document.new(:page_size => "A5", :page_layout => :portrait)

    # Template
    pdf.image "#{image_path}/pdf_template.png", at: [-10, 545], scale: 1, width: 370

    left_column_x = -2
    right_column_x = 183
    top_row_y = 455
    bottom_row_y = 200

    # Basic/BMI
    render_card pdf, left_column_x, top_row_y,
      "Your BMI is",
      @user_data.bmi_risk_score,
      @user_data.bmi_score_name,
      @user_data.lookup(UserData::BMI_SCORES, @user_data.bmi_score, :so_what, ""),
      @user_data.lookup(UserData::BMI_SCORES, @user_data.bmi_score, :what_now, "")

    # Physical
    if @user_data.physical_complete?
      render_card pdf, right_column_x, top_row_y,
        "Physically you are",
        @user_data.physical_risk_score,
        @user_data.lookup(UserData::PHYSICAL_SCORES, @user_data.physical_risk_score, :name, ""),
        @user_data.lookup(UserData::PHYSICAL_SCORES, @user_data.physical_risk_score, :so_what, ""),
        @user_data.lookup(UserData::PHYSICAL_SCORES, @user_data.physical_risk_score, :what_now, "")
    else
      render_incomplete_card pdf, right_column_x, top_row_y, "Check your physical activity on your next visit to the Health Pod"
    end

    # Diabetes
    if @user_data.diabetes_complete?
      render_card pdf, left_column_x, bottom_row_y,
        "Your diabetes risk score is",
        @user_data.diabetes_risk_score,
        @user_data.diabetes_score.to_s,
        @user_data.lookup(UserData::DIABETES_SCORES, @user_data.diabetes_risk_score, :so_what, ""),
        @user_data.lookup(UserData::DIABETES_SCORES, @user_data.diabetes_risk_score, :what_now, "")
    else
      render_incomplete_card pdf, left_column_x, bottom_row_y, "Check your Type 2 diabetes risk on your next visit to the Health Pod"
    end

    # Alcohol
    if @user_data.alcohol_complete?
      render_card pdf, right_column_x, bottom_row_y,
        "Your alcohol consumption is",
        @user_data.alcohol_risk_score,
        @user_data.lookup(UserData::ALCOHOL_SCORES, @user_data.alcohol_risk_score, :name, ""),
        @user_data.lookup(UserData::ALCOHOL_SCORES, @user_data.alcohol_risk_score, :so_what, ""),
        @user_data.lookup(UserData::ALCOHOL_SCORES, @user_data.alcohol_risk_score, :what_now, "")
    else
      render_incomplete_card pdf, right_column_x, bottom_row_y, "Check your alcohol consumption on your next visit to the Health Pod"
    end

    # Debug co-ordinates
    # pdf.stroke_axis

    # Done
    pdf.render_file @file_path
  end

  def render_incomplete_card(pdf, x, y, heading)
    font_name = "Helvetica"
    font_size = 9
    font_color = "999999"
    margin = 10

    # Heading
    pdf.fill_color font_color
    pdf.font font_name, size: font_size
    pdf.text_box heading, at: [x + margin, y - 80], width: 150, align: :center
  end

  def render_card(pdf, x, y, heading, score, score_name, so_what, what_now)
    image_path = "#{Rails.root}/app/assets/images/pdf"
    font_name = "Helvetica"
    font_size = 7
    font_color = "000000"
    large_font_size = 22
    box_width = 155
    margin = 7

    # Heading
    pdf.fill_color font_color
    pdf.font font_name, size: font_size
    pdf.text_box heading, at: [x + 50, y], width: box_width, align: :left

    # Score
    pdf.fill_color risk_font_color(score)
    pdf.font font_name, size: large_font_size, style: :bold
    pdf.text_box score_name, at: [x, y - 20], width: 175, height: 13, align: :center, overflow: :shrink_to_fit

    # so_what
    pdf.fill_color font_color
    pdf.font font_name, size: font_size
    pdf.text_box so_what, at: [x + margin, y - 45], width: 150, height: 50

    # "Risk level"
    pdf.fill_color font_color
    pdf.font font_name, size: font_size, style: :bold
    pdf.text_box "Risk level", at: [x + margin, y - 100], width: box_width, align: :left

    # Scale
    pdf.image "#{image_path}/#{risk_image(score)}", at: [x + margin, y - 110], scale: 1, width: box_width

    # "What now?"
    pdf.fill_color font_color
    pdf.font font_name, size: font_size, style: :bold
    pdf.text_box "What now?", at: [x + margin, y - 150], width: box_width, align: :left

    # what_now
    pdf.fill_color font_color
    pdf.font font_name, size: font_size, style: :normal
    pdf.text_box what_now, at: [x + margin, y - 160], width: box_width, align: :left
  end

  def risk_image(risk)
    case risk
    when 2
      return "medium_risk.png"
    when 3
      return "high_risk.png"
    else
      return "low_risk.png"
    end
  end

  def risk_font_color(risk)
    case risk
    when 2
      return "EE9E35"
    when 3
      return "AB2430"
    else
      return "92AD9F"
    end
  end

end
