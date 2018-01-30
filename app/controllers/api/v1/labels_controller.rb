class Api::V1::LabelsController < ApplicationController
  before_action :authenticate_api_v1_user!

  def index
    label_list = []
      current_api_v1_user.thoughts.each do |thought|
        if !label_list.include? thought.labels[0].name
          label_list << thought.labels[0].name
        end
      end
    render json: { labels: label_list }
  end
end
