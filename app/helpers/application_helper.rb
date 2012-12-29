module ApplicationHelper
  def flash_message_class(flash_type)
    message_class = "message"
    case flash_type.to_s
    when 'error'
      message_class += " red-gradient"
    when 'notice'
      message_class += " blue-gradient"
    when 'alert'
      message_class += " red-gradient"
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

  def unread_count
    current_user.envelopes.unread_count
  end

  def full_title(page_title)
    base_title = "Club Manager"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def main_title(page_title)
    base_title = "Club Manager"
    if page_title.empty?
      base_title
    else
      page_title
    end
  end

  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to(name, '#', class: 'add_fields button icon-list-add', data: { id: id, fields: fields.gsub("\n", "")})
  end

end
