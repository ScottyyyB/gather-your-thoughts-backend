require 'rails_helper'

RSpec.describe Api::V1::EntriesController, type: :request do
  let(:user) { FactoryBot.create(:user)}
  let(:credentials) { user.create_new_auth_token }
  let(:headers) { { HTTP_ACCEPT: 'application/json'}.merge!(credentials) }
  let(:headers_sad) { { HTTP_ACCEPT: 'application/json' } }
  before do
    5.times { FactoryBot.create(:entry, user: user) }
  end

  describe 'POST /v1/entries' do
    it 'creates an entry' do
      post '/api/v1/entries', params: {
        entry: {
          title: "Hello", body: "World",
          label_list: "Family, Music",
          sentiment_list: "Happy"
        }
      }, headers: headers

      expect(response_json['status']).to eq 'success'
      expect(response.status).to eq 200
    end

    it 'creates an entry without title' do
      post '/api/v1/entries', params: {
        entry: {
          body: "World",
          label_list: "Family",
          sentiment_list: "Sad"
        }
      }, headers: headers

      expect(response_json['error']).to eq ["Title can't be blank"]
      expect(response.status).to eq 422
    end

    it 'creates an entry without body' do
      post '/api/v1/entries', params: {
        entry: {
          title: "Hello",
          label_list: "Family",
          sentiment_list: "Excited"
        }
      }, headers: headers

      expect(response_json['error']).to eq ["Body can't be blank"]
      expect(response.status).to eq 422
    end

    it 'gives error message if no user is present' do
      post '/api/v1/entries', params: {
          entry: {
              title: "Hello",
              label_list: "Family",
              sentiment_list: "Excited"
          }
      }, headers: headers_sad
      expect(response_json["errors"]).to eq ["You need to sign in or sign up before continuing."]
    end
  end

  describe 'GET /v1/entries/entry_id' do
    it 'returns a specific entry' do
      get "/api/v1/entries/#{Entry.last.id}", headers: headers
      expect(response.status).to eq 200
      expected_response = eval(file_fixture('entries_show.txt').read)
      expect(response_json).to eq expected_response.as_json
    end
  end

  describe 'DELETE /v1/entries/entry_id' do
    it 'deletes a specific entry' do
      delete "/api/v1/entries/#{Entry.last.id}", headers: headers
      expect(response.status).to eq 200
      expected_response = eval(file_fixture('entry_delete.txt').read)
      expect(response_json).to eq expected_response.as_json
    end
  end

  describe 'GET /v1/entries/entry_id' do
    it 'returns a specific entry' do
      get "/api/v1/entries/#{Entry.last.id}", headers: headers
      expect(response.status).to eq 200
      expected_response = eval(file_fixture('entries_show.txt').read)
      expect(response_json).to eq expected_response.as_json
    end
  end

  describe 'GET /v1/entries' do
    it 'returns a the 3 latest entries' do
      get '/api/v1/entries', headers: headers
      expect(response.status).to eq 200
      expected_response = eval(file_fixture('entries_index.txt').read)
      expect(response_json).to eq expected_response.as_json
    end
  end

  describe 'GET /v1/entries/entry_id' do
    it 'edits a specific entry' do
      put "/api/v1/entries/#{Entry.last.id}", params: {
        entry: { title: 'New title', body: 'New body' }
      }, headers: headers
      expect(response.status).to eq 200
      expected_response = eval(file_fixture('edit_entry.txt').read)
      expect(response_json).to eq expected_response.as_json
    end

    it 'does not edit if title is blank' do
      put "/api/v1/entries/#{Entry.last.id}", params: {
        entry: { title: '', body: 'New Body' }
      }, headers: headers
      expect(response.status).to eq 422
      expect(response_json['error']).to eq ["Title can't be blank"]
    end

    it 'does not edit if body is blank' do
      put "/api/v1/entries/#{Entry.last.id}", params: {
        entry: { title: 'New title', body: '' }
      }, headers: headers
      expect(response.status).to eq 422
      expect(response_json['error']).to eq ["Body can't be blank"]
    end
  end
end
