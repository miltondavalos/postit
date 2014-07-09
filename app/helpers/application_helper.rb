module ApplicationHelper
  def fix_url(str)
    str.starts_with?('http://') ? str : "http://#{str}"
  end

  def fix_date(date_time)
    date_time.strftime('%d/%m/%Y %l:%M %p %Z')
  end
end
