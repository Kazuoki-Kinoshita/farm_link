module SelectDatetimeHelper
  def select_datetime(datetime, options = {})
    field = options[:from]

    month_name = I18n.l(datetime, format: '%B')

    select datetime.year, from: "#{field}_1i"
    select month_name, from: "#{field}_2i"
    select datetime.day, from: "#{field}_3i"
    select datetime.hour, from: "#{field}_4i"
    select datetime.minute, from: "#{field}_5i"
  end
end

RSpec.configure do |config|
  config.include SelectDatetimeHelper, type: :system
end
