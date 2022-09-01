require 'httparty'
require 'interactor'

class SendMessage
  include Interactor

  SEND_MESSAGE_URL = "#{ENV['SLACKBOT_SERVICE_URL']}/slack/messages".freeze

  def call
    HTTParty.post(SEND_MESSAGE_URL, body: body, headers: headers)
  end

  private

  def channel_id
    ENV['RANDOM_CHANNEL_ID']
  end

  def body
    {
      channel: channel_id,
      text: context.joke_text,
      thread_ts: context.ts
    }.to_json
  end

  def headers
    {
      'Content-Type': 'application/json',
      'x-api-key': ENV['SLACKBOT_SERVICE_API_KEY']
    }
  end
end