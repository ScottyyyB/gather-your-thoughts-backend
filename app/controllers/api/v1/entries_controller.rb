class Api::V1::EntriesController < ApplicationController
  before_action :authenticate_api_v1_user!

  def create
    entry = Entry.new(entry_params.merge(user: current_api_v1_user))
    entry.label_list.add(params[:label_list])
    entry.sentiment_list.add(params[:sentiment_list])

    if entry.save
      render json: { status: 'success' }
    else
      render json: { error: entry.errors.full_messages },
             status: 422
    end
  end

  def show
    entry = Entry.find(params[:id])
    render json: entry, serializer: EntriesSerializer
  end

  def destroy
    entry = Entry.find(params[:id]).delete
    render json: { message: "#{entry.title} has been successfully deleted." }
  end

  def index
    entries = current_api_v1_user.entries.last(3)
    render json: entries, each_serializer: EntriesSerializer
  end

  def update
    entry = Entry.find(params[:id])
    if entry.update(entry_params)
      render json: { message: "#{entry.title} has been successfully updated." }
    else
      render json: { error: entry.errors.full_messages },
             status: 422
    end
  end

  private

  def entry_params
    params.require(:entry).permit!
  end
end
