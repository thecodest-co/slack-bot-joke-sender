require 'httparty'

class DownloadJoke
  JOKES_API_URL = 'https://v2.jokeapi.dev/joke/Any?blacklistFlags=nsfw,religious,racist,sexist,explicit&format=json'.freeze

  def self.call
    response = HTTParty.get(JOKES_API_URL)
    body = JSON.parse(response.body)

    return adjust_joke(body) if response.code == 200 && body['error'] == false
    puts "Unable to get a joke from an external API"
  end

  def self.adjust_joke(body)
    if body['type'] == 'single'
      joke_text = body['joke']
    else
      joke_text = body['setup'] + "\n" + body['delivery']
    end
    joke_text
  end
end