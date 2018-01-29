class Api::V1::ThoughtsController < ApplicationController
  def create
    thought = Thought.new(thought_params)
    if thought.save
      render json: { status: 'success' }
    else
      render json: { error: thought.errors.full_messages },
             status: 422
    end
  end

  private

  def thought_params
    params.require(:thought).permit!
  end
end
