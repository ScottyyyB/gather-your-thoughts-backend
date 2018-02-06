RSpec.describe Api::V1::ActivityController, type: :request do
  let(:user) { FactoryBot.create(:user)}
  let(:credentials) { user.create_new_auth_token }
  let(:headers) { { HTTP_ACCEPT: 'application/json'}.merge!(credentials) }
  before do
    5.times { FactoryBot.create(:entry, user: user, created_at: Date.yesterday) }
    2.times { FactoryBot.create(:entry, user: user, created_at: Date.today - 4) }
  end

  describe 'GET /v1/activity' do
    it 'returns thoughts for each day over the past week' do
      get '/api/v1/activity', headers: headers
      expect(response.status).to eq 200
      expected_response = eval(file_fixture('entries_for_week.txt').read)
      expect(response_json).to eq expected_response.as_json
    end
  end
end
