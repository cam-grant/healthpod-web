module ApplicationHelper

  def progress_bar(percent_complete, minutes_remaining)
    complete_width = 400 * (percent_complete / 100.to_f)
    html =  "<div id='progress'>"
    html << "<div class='total'><div class='current' style='width: #{complete_width}px;'></div></div>"
    html << "<div>About #{pluralize(minutes_remaining, 'minute')} remaining</div>"
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
