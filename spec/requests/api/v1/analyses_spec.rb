RSpec.describe Api::V1::AnalysesController, type: :request do
  #let(:user) { FactoryBot.create(:user)}
  #let(:credentials) { user.create_new_auth_token }

  describe 'get /v1/analyses' do
    it 'gets suggestions for labels' do
      get "/api/v1/analyses?text=I love my coffee. It is so great when I want to wake up in the morning"
      expect(response.status).to eq 200
      binding.pry
    end
  end
end