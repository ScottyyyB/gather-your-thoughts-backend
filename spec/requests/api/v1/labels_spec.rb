RSpec.describe Api::V1::LabelsController, type: :request do
  let(:user) { FactoryBot.create(:user)}
  let(:credentials) { user.create_new_auth_token }
  let(:headers) { { HTTP_ACCEPT: 'application/json'}.merge!(credentials) }
  before do
    5.times { FactoryBot.create(:thought, label_list: "Family", user: user) }
  end

  describe 'GET /v1/labels' do
    it 'returns all labels for a specific user' do
      get '/api/v1/labels', headers: headers
      expect(response.status).to eq 200
      expected_response = eval(file_fixture('labels.txt').read)
      expect(response_json).to eq expected_response.as_json
    end
  end

  describe 'GET /v1/labels/label_id' do
    it 'returns all thoughts for a specific label' do
      get "/api/v1/labels/#{user.thoughts.first.labels.first.id}", headers: headers
      expect(response.status).to eq 200
      #expected_response = eval(file_fixture('thoughts_for_label.txt').read)
      #expect(response_json).to eq expected_response.as_json
    end
  end
end
