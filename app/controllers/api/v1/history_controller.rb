class Api::V1::HistoryController < ApplicationController
  before_action :authenticate_api_v1_user!

  def index
    thoughts = []
    current_api_v1_user.thoughts.each do |thought|
      if Time.strptime(thought.created_at.to_s, "%Y-%m-%d") == Time.strptime(params[:date], "%Y-%m-%d")
        thoughts << thought
      end
    end
    render json: thoughts, each_serializer: ThoughtsSerializer
  end
end
