module TasksHelper
  def date_format(date)
    date.strftime("%A %B %-d, %Y") unless date.blank?
  end
end
