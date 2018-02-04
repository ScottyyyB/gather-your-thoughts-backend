require 'rails_helper'

RSpec.describe Api::V1::HistoryController, type: :request do
  let(:user) { FactoryBot.create(:user)}
  let(:credentials) { user.create_new_auth_token }
  let(:headers) { { HTTP_ACCEPT: 'application/json'}.merge!(credentials) }
  before do
    3.times { FactoryBot.create(:entry, user: user) }
    FactoryBot.create(:entry, user: user, created_at: Time.now.yesterday)
  end

  describe 'get /v1/history' do
    it 'gets entries sorted by date' do
      get "/api/v1/history?date=#{Time.now}", headers: headers
      expect(response.status).to eq 200
      expected_response = eval(file_fixture('entries_for_date.txt').read)
      expect(response_json).to eq expected_response.as_json
    end
  end
end
