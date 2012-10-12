module TasksHelper
  def date_format(date)
    date.strftime("%A %B %-d, %Y")
  end
end
