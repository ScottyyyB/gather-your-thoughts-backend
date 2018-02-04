class Api::V1::SentimentsController < ApplicationController
  before_action :authenticate_api_v1_user!

  def index
    sentiment_list = []
    current_api_v1_user.thoughts.each do |thought|
      if sentiment_list.none? { |sentiment| sentiment.name == thought.sentiments[0].name }
        thought.sentiments[0].taggings_count = current_api_v1_user.thoughts.tagged_with(thought.sentiments[0].name).count
        sentiment_list << thought.sentiments[0]
      end
    end
    render json: { sentiments: sentiment_list }
  end

  def show
    sentiment = current_api_v1_user.thoughts.sentiment_counts.find(params[:id])
    thoughts = current_api_v1_user.thoughts.tagged_with(sentiment.name)
    render json: thoughts, each_serializer: ThoughtsSerializer
  end

  def statistics
    sentiment_list = []
    current_api_v1_user.thoughts.where("created_at >= ?", 1.month.ago).each do |thought|
      if sentiment_list.none? { |sentiment| sentiment.name == thought.sentiments[0].name }
        thought.sentiments[0].taggings_count = current_api_v1_user.thoughts.tagged_with(thought.sentiments[0].name).count
        sentiment_list << thought.sentiments[0]
      end
    end
    render json: { sentiments: sentiment_list}
  end
end
