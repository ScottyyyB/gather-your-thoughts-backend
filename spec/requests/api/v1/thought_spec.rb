require 'rails_helper'

RSpec.describe Api::V1::ThoughtsController, type: :request do

  describe 'POST /v1/thoughts' do
    it 'creates a thought' do
      post '/api/v1/thoughts', params: {
          thought: {data: {
              title: "Hello",
              body: "World"
          }}
      }
      expect(response_json['status']).to eq 'success'
      expect(response.status).to eq 200
    end
  end
end