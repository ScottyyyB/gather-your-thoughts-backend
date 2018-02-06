class Api::V1::ActivityController < ApplicationController
  def index
    entries_week = week_entries

    entries_months = six_month_entries
    render json: { week: entries_week, months: entries_months }
  end
end
