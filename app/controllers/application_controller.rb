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

  def sentiments_week
    sentiment_list = []
    weekly_entries = current_api_v1_user.entries.select { |entry| entry.created_at >= 1.week.ago }
    weekly_entries.entries.each do |entry|
      sentiment_list << entry.sentiment_list
    end
    counts = Hash.new(0)
    sentiment_list.each { |sentiment| counts[sentiment] += 1 }
    counts.sort.reverse!
    counts.delete_if { |key, value| value < counts.first[1] }
    return counts
  end
end
