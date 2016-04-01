module ApplicationHelper

  def progress_bar()
    return if session[:current_step].blank?
    percent_complete = session[:current_step].fdiv(session[:total_steps])

    complete_width = 600 * percent_complete
    html =  "<div id='progress'>"
    html << "<div class='total'><div class='current' style='width: #{complete_width}px;'></div></div>"
    html << "<div>Step #{session[:current_step]} / #{session[:total_steps]}</div>"
    html << "</div>"
    html.html_safe
  end

  def next_button(action, href = "#", label = "Next")
    btn = '<a href="'
    btn << href
    btn << '" '
    btn << 'id="next" class="nav next disabled" '
    btn << 'onclick="if ($(this).hasClass(\'disabled\')) return false;'
    btn << action unless action.blank?
    btn << ';return false;' if href == "#"
    btn << "\">#{label}</a>"
    btn.html_safe
  end

  def svg_use(img, options = nil)
    svg = "<svg preserveAspectRatio='xMinYMin meet'"
    svg << " class='#{options[:class]}'" if options && options[:class].present?
    svg << " style='#{options[:style]}'" if options && options[:style].present?
    svg << "><use xlink:href='#{img}'></use></svg>"
    svg.html_safe
  end

  def risk_image(risk)
    case risk
    when 1
      return image_tag "low_risk.svg"
    when 2
      return image_tag "medium_risk.svg"
    when 3
      return image_tag "high_risk.svg"
    end
  end

end
