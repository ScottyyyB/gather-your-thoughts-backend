class Api::V1::HistoryController < ApplicationController
  before_action :authenticate_api_v1_user!

  def index
    entries = []
    current_api_v1_user.entries.each do |entry|
      if Time.strptime(entry.created_at.to_s, "%Y-%m-%d") == Time.strptime(params[:date], "%Y-%m-%d")
        entries << entry
      end
    end
    render json: entries, each_serializer: EntriesSerializer
  end
end
