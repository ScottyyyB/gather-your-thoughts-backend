require 'rails_helper'

RSpec.describe Api::V1::ThoughtsController, type: :request do
  let(:headers) { { HTTP_ACCEPT: 'application/json'} }

  describe 'POST /v1/thoughts' do
    it 'creates a thought' do
      post '/api/v1/thoughts', params: {
        thought: {
          title: "Hello", body: "World",
          label_list: "Family, Music",
          sentiment_list: "Happy"
        }
      }, headers: headers

      expect(response_json['status']).to eq 'success'
      expect(response.status).to eq 200
    end

    it 'creates a thought without title' do
      post '/api/v1/thoughts', params: {
        thought: {
          body: "World",
          label_list: "Family",
          sentiment_list: "Sad"
        }
      }, headers: headers

      expect(response_json['error']).to eq ["Title can't be blank"]
      expect(response.status).to eq 422
    end

    it 'creates a thought without body' do
      post '/api/v1/thoughts', params: {
        thought: {
          title: "Hello",
          label_list: "Family",
          sentiment_list: "Excited"
        }
      }, headers: headers

      expect(response_json['error']).to eq ["Body can't be blank"]
      expect(response.status).to eq 422
    end
  end
end
