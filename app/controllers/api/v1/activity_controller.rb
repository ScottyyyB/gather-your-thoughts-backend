class Api::V1::ActivityController < ApplicationController
  before_action :authenticate_api_v1_user!

  def index
    render json: { week: week_entries, months: six_month_entries, sentiment_week: sentiments_week }
  end
end
