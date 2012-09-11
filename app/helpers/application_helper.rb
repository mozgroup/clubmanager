module ApplicationHelper
  def flash_message_class(flash_type)
    message_class = "message"
    case flash_type.to_s
    when 'error'
      message_class += " red-gradient"
    when 'notice'
      message_class += " blue-gradient"
    when 'alert'
      message_class += " orange-gradient"
    else
      message_class += " blue-gradient"
    end
  end
end
