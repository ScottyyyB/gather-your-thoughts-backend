class Api::V1::LabelsController < ApplicationController
  before_action :authenticate_api_v1_user!

  def index
    label_list = []
    current_api_v1_user.thoughts.each do |thought|
      if label_list.none? { |label| label.name == thought.labels[0].name }
        label_list << thought.labels[0]
      end
    end
    render json: { labels: label_list }
  end

  def show
    label = Thought.label_counts.find(params[:id])
    thoughts = Thought.tagged_with(label.name)
    render json: thoughts, each_serializer: ThoughtsSerializer
  end
end
