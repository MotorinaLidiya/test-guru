module ApplicationHelper
  def flash_message
    flash.map do |key, message|
      next unless message.present?

      content_tag :p, message, class: "flash #{key}"
    end.join.html_safe
  end
end
