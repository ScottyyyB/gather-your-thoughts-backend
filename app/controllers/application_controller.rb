class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken

  def six_month_entries
    entries = []
    count = 5
    while count > -1
      obj = {amount: current_api_v1_user.entries.count do |entry|
        Time.strptime(entry.created_at.to_s, "%Y-%m") == Time.strptime(Date.today.months_ago(count).to_s, "%Y-%m")
      end, month: Date::MONTHNAMES[Date.today.months_ago(count).mon].slice(0, 3)}
      entries << obj
      count -= 1
    end
    return entries
  end

  def week_entries
    entry_list = []
    date = Date.today
    count = 6
    while count > -1
      entry = {amount: current_api_v1_user.entries.count do |entry|
        Date.parse(entry.created_at.to_s) == date - count
      end, date: date - count}
      entry_list << entry
      count -= 1
    end
    return entry_list
  end
end
