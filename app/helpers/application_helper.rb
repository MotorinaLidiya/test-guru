module ApplicationHelper
  def flash_message
    safe_join(flash.map do |key, message|
      next if message.blank?

      alert_class = case key
                    when 'notice' then 'alert alert-info'
                    when 'success' then 'alert alert-success'
                    when 'error' then 'alert alert-danger'
                    when 'alert' then 'alert alert-warning'
                    else 'alert alert-secondary'
                    end

      content_tag :div, sanitize(message), class: alert_class
    end.compact)
  end
end
