module ApplicationHelper
  def flash_message
    flash.map do |key, message|
      next unless message.present?

      alert_class = case key
                    when "notice" then "alert alert-info"
                    when "success" then "alert alert-success"
                    when "error" then "alert alert-danger"
                    when "alert" then "alert alert-warning"
                    else "alert alert-secondary"
                    end

      content_tag :div, message.html_safe, class: alert_class
    end.join.html_safe
  end
end
