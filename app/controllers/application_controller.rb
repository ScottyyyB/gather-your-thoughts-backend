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
    count = 0
    sentiment_list = []
    weekly_entries = current_api_v1_user.entries.select { |entry| entry.created_at >= 1.week.ago }
    weekly_entries.entries.each do |entry|
      if sentiment_list.none? { |sentiment| sentiment.name == entry.sentiments[0].name }
        entry.sentiments[0].taggings_count = weekly_entries.count do |entry|
          entry.sentiments[0].name == current_api_v1_user.entries.sentiment_counts[count].name
        end
        sentiment_list << entry.sentiments[0]
        count += 1
      end
    end
    sentiment_list.sort_by!(&:taggings_count).reverse!
    count2 = sentiment_list.length - 1
    while count2 > 0
      unless sentiment_list[count2].taggings_count == sentiment_list[0].taggings_count
        sentiment_list.pop
      end
      count2 -= 1
    end
    return sentiment_list
  end
end
