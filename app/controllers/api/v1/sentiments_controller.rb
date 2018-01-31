class Api::V1::SentimentsController < ApplicationController
  before_action :authenticate_api_v1_user!

  def index
    sentiment_list = []
    current_api_v1_user.thoughts.each do |thought|
      if sentiment_list.none? { |sentiment| sentiment.name == thought.sentiments[0].name }
        sentiment_list << thought.sentiments[0]
      end
    end
    render json: { sentiments: sentiment_list }
  end
end
