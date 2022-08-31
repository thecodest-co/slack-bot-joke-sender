require_relative 'services/send_joke'
require_relative 'services/download_joke'
require 'json'

def event_handler(event:, context:)
  event = JSON.parse(event['body'])

  if event['type'] == 'app_mention' && event['channel'] == ENV['RANDOM_CHANNEL_ID']
    result = SendJoke.call(ts: event['ts'])
    puts result.error unless result.success?
  end
  { statusCode: 200 }
end

def send_joke(event:, context:)
  result = SendJoke.call 
  puts result.error unless result.success?
end