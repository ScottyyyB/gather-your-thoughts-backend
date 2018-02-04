class Api::V1::LabelsController < ApplicationController
  before_action :authenticate_api_v1_user!

  def index
    label_list = []
    current_api_v1_user.entries.each do |entry|
      if label_list.none? { |label| label.name == entry.labels[0].name }
        entry.labels[0].taggings_count = current_api_v1_user.entries.tagged_with(entry.labels[0].name).count
        label_list << entry.labels[0]
      end
    end
    render json: { labels: label_list }
  end

  def show
    label = current_api_v1_user.entries.label_counts.find(params[:id])
    entries = current_api_v1_user.entries.tagged_with(label.name)
    render json: entries, each_serializer: EntriesSerializer
  end
end
