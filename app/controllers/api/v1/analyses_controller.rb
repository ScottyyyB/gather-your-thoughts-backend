class Api::V1::AnalysesController < ApplicationController
  before_action :authenticate_api_v1_user!

  def index
    require 'net/https'
    uri = 'https://westcentralus.api.cognitive.microsoft.com'
    path = '/text/analytics/v2.0/keyPhrases'

    uri = URI(uri + path)
    documents = { 'documents': [
        { 'id' => '1', 'language' => 'en', 'text' => "#{params[:text]}" }
    ]}

    request = Net::HTTP::Post.new(uri)
    request['Content-Type'] = "application/json"
    request['Ocp-Apim-Subscription-Key'] = ENV['TEXT_API']
    request.body = documents.to_json

    response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
      http.request (request)
    end

    render json: response.body
  end
end