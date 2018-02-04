RSpec.describe Api::V1::SentimentsController, type: :request do
  let(:user) { FactoryBot.create(:user)}
  let(:credentials) { user.create_new_auth_token }
  let(:headers) { { HTTP_ACCEPT: 'application/json'}.merge!(credentials) }
  before do
    3.times { FactoryBot.create(:thought, sentiment_list: "Happy", label_list: "Gaming", user: user ) }
  end

  describe 'GET /v1/sentiments' do
    it 'should return all sentiments for a user' do
      get '/api/v1/sentiments', headers: headers
      expect(response.status).to eq 200
      expected_response = eval(file_fixture('sentiments.txt').read)
      expect(response_json).to eq expected_response.as_json
    end
  end

  describe 'GET /v1/sentiments/sentiment_id' do
    it 'should return all thoughts for a sentiment' do
      get "/api/v1/sentiments/#{user.thoughts.first.sentiments.first.id}", headers: headers
      expect(response.status).to eq 200
      expected_response = eval(file_fixture('thoughts_for_sentiment.txt').read)
      expect(response_json).to eq expected_response.as_json
    end
  end

  describe 'GET /v1/sentiments/statistics' do
    it 'should return all sentiments from the last month' do
      get '/api/v1/sentiments/statistics', headers: headers
      expect(response.status).to eq 200
      expected_response = eval(file_fixture('sentiments_for_last_month.txt').read)
      expect(response_json).to eq expected_response.as_json
    end
  end
end
