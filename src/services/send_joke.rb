require 'httparty'

class SendJoke
  SEND_MESSAGE_URL = "#{ENV['SLACKBOT_SERVICE_URL']}/slack/messages".freeze

  def initialize(ts = nil)
    @ts = ts
  end

  def call
    HTTParty.post(SEND_MESSAGE_URL, body: body, headers: headers) if joke_text != nil
  end

  private

  attr_reader :ts

  def joke_text
    @joke_text ||= DownloadJoke.call
  end

  def channel_id
    ENV['RANDOM_CHANNEL_ID']
  end

  def body
    {
      channel: channel_id,
      text: joke_text,
      thread_ts: ts
    }.to_json
  end

  def headers
    {
      'Content-Type': 'application/json',
      'x-api-key': ENV['SLACKBOT_SERVICE_API_KEY']
    }
  end
end