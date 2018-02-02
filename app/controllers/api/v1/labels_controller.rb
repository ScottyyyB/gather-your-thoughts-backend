class Api::V1::LabelsController < ApplicationController
  before_action :authenticate_api_v1_user!

  def index
    label_list = []
    current_api_v1_user.thoughts.each do |thought|
      if label_list.none? { |label| label.name == thought.labels[0].name }
        thought.labels[0].taggings_count = current_api_v1_user.thoughts.tagged_with(thought.labels[0].name).count
        label_list << thought.labels[0]
      end
    end
    render json: { labels: label_list }
  end

  def show
    label = current_api_v1_user.thoughts.label_counts.find(params[:id])
    thoughts = current_api_v1_user.thoughts.tagged_with(label.name)
    render json: thoughts, each_serializer: ThoughtsSerializer
  end
end
