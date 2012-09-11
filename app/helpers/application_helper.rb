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

  def dashboard_date
    c_date = Date.today
    "#{c_date.strftime('%b').downcase} <strong>#{c_date.strftime('%d')}</strong>".html_safe
  end

  def dashboard_user(user)
    content_tag :span, class: 'name' do
      (user.first_name.downcase.camelize + ' ' +  content_tag(:b, user.last_name.downcase.camelize)).html_safe
    end
  end

  # Returns the Gravatar (http://gravatar.com/) for the given user.
  def gravatar_for(user, options = { size: 50 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.full_name, class: 'user-icon')
  end
end
