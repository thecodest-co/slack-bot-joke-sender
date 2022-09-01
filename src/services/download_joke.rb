require 'httparty'
require 'interactor'

class DownloadJoke
  include Interactor

  JOKES_API_URL = 'https://v2.jokeapi.dev/joke/Any?blacklistFlags=nsfw,religious,racist,sexist,explicit&format=json'.freeze

  def call
    response = HTTParty.get(JOKES_API_URL)
    context.body = JSON.parse(response.body)

    context.fail!(error: "Unable to get a joke from an external API") if response.code != 200 || context.body['error'] == true
  end
end