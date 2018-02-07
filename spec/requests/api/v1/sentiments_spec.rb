RSpec.describe Api::V1::SentimentsController, type: :request do
  let(:user) { FactoryBot.create(:user)}
  let(:credentials) { user.create_new_auth_token }
  let(:headers) { { HTTP_ACCEPT: 'application/json'}.merge!(credentials) }
  before do
    3.times { FactoryBot.create(:entry, user: user ) }
    1.times { FactoryBot.create(:entry, user: user, sentiment_list: "Excited", created_at: Date.today - 40 ) }
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
    it 'should return all entries for a sentiment' do
      get "/api/v1/sentiments/#{user.entries.first.sentiments.first.id}", headers: headers
      expect(response.status).to eq 200
      expected_response = eval(file_fixture('entries_for_sentiment.txt').read)
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
