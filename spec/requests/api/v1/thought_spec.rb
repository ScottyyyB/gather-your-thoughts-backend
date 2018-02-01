require 'rails_helper'

RSpec.describe Api::V1::ThoughtsController, type: :request do
  let(:user) { FactoryBot.create(:user)}
  let(:credentials) { user.create_new_auth_token }
  let(:headers) { { HTTP_ACCEPT: 'application/json'}.merge!(credentials) }
  let(:headers_sad) { { HTTP_ACCEPT: 'application/json' } }

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

    it 'gives error message if no user is present' do
      post '/api/v1/thoughts', params: {
          thought: {
              title: "Hello",
              label_list: "Family",
              sentiment_list: "Excited"
          }
      }, headers: headers_sad
      expect(response_json["errors"]).to eq ["You need to sign in or sign up before continuing."]
    end
  end

  describe 'GET /v1/thoughts/thought_id' do
    before do
      FactoryBot.create(:thought, user: user)
    end

    it 'returns a specific thought' do
      get "/api/v1/thoughts/#{Thought.last.id}", headers: headers
      expect(response.status).to eq 200
      expected_response = eval(file_fixture('thoughts_show.txt').read)
      expect(response_json).to eq expected_response.as_json
    end
  end
end
