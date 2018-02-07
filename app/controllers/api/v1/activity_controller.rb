class Api::V1::ActivityController < ApplicationController
  def index
    render json: { week: week_entries, months: six_month_entries, sentiment_week: sentiments_week }
  end
end
