class Api::V1::ThoughtsController < ApplicationController
  before_action :authenticate_api_v1_user!

  def create
    thought = Thought.new(thought_params.merge(user: current_api_v1_user))
    thought.label_list.add(params[:label_list])
    thought.sentiment_list.add(params[:sentiment_list])

    if thought.save
      render json: { status: 'success' }
    else
      render json: { error: thought.errors.full_messages },
             status: 422
    end
  end

  def show
    thought = Thought.find(params[:id])
    render json: thought, serializer: ThoughtsSerializer
  end

  def destroy
    thought = Thought.find(params[:id]).delete
    render json: { message: "#{thought.title} has been successfully deleted." }
  end

  private

  def thought_params
    params.require(:thought).permit!
  end
end
