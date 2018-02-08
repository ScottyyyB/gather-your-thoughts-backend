RSpec.describe Api::V1::AnalysesController, type: :request do
  let(:user) { FactoryBot.create(:user)}
  let(:credentials) { user.create_new_auth_token }
  let(:headers) { { HTTP_ACCEPT: 'application/json'}.merge!(credentials) }

  describe 'get /v1/analyses' do
    it 'gets suggestions for labels' do
      get "/api/v1/analyses?text=I love my coffee. It is so great when I want to wake up in the morning", headers: headers
      expect(response.status).to eq 200
      expected_response = eval(file_fixture('text_analysis.txt').read)
      expect(response_json).to eq expected_response.as_json
    end
  end
end