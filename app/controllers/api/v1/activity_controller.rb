class Api::V1::ActivityController < ApplicationController
  def index
    entry_list = []
    date = Date.today
    count = 6
    while count > -1
      entry = { amount: current_api_v1_user.entries.select do |entry|
        Date.parse(entry.created_at.to_s) == date - count
      end.count, date: date - count }
      entry_list << entry
      count -= 1
    end
    render json: { week: entry_list }
  end
end
