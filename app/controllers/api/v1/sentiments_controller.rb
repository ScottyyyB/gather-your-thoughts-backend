class Api::V1::SentimentsController < ApplicationController
  before_action :authenticate_api_v1_user!

  def index
    sentiment_list = []
    current_api_v1_user.entries.each do |entry|
      if sentiment_list.none? { |sentiment| sentiment.name == entry.sentiments[0].name }
        entry.sentiments[0].taggings_count = current_api_v1_user.entries.tagged_with(entry.sentiments[0].name).count
        sentiment_list << entry.sentiments[0]
      end
    end
    render json: { sentiments: sentiment_list }
  end

  def show
    sentiment = current_api_v1_user.entries.sentiment_counts.find(params[:id])
    entries = current_api_v1_user.entries.tagged_with(sentiment.name)
    render json: entries, each_serializer: EntriesSerializer
  end

  def statistics
    sentiment_list = []
    count = 0
    monthly_entries = current_api_v1_user.entries.select { |entry| entry.created_at >= 1.month.ago }
    monthly_entries.entries.each do |entry|
      if sentiment_list.none? { |sentiment| sentiment.name == entry.sentiments[0].name }
        entry.sentiments[0].taggings_count = monthly_entries.count do |entry|
          entry.sentiments[0].name == current_api_v1_user.entries.sentiment_counts[count].name
        end
        sentiment_list << entry.sentiments[0]
        count += 1
      end
    end
    render json: { sentiments: sentiment_list}
  end
end
