class Api::V1::ActivityController < ApplicationController
  def index
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
    while count2 > -1
      unless sentiment_list[count2].taggings_count == sentiment_list[0].taggings_count
        sentiment_list.pop
      end
      count2 -= 1
    end
    render json: { week: week_entries, months: six_month_entries, sentiment_week: sentiment_list }
  end
end
