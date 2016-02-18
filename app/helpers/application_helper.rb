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

  def next_button(action, href = "#")
    btn = '<a href="'
    btn << href
    btn << '" '
    btn << 'id="next" class="nav next disabled" '
    btn << 'onclick="if ($(this).hasClass(\'disabled\')) return false;'
    btn << action unless action.blank?
    btn << ';return false;' if href == "#"
    btn << '">Next</a>'
    btn.html_safe
  end

end
