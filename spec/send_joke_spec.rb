require 'spec_helper'

RSpec.describe SendJoke do
  subject { described_class.new(ts).call }

  let(:ts) { '123.456' }
  let(:joke_text) { 'joke' }

  let(:expected_headers) do
    {
      'Content-Type': 'application/json',
      'x-api-key': ENV['SLACKBOT_SERVICE_API_KEY']
    }
  end

  let(:expected_body) do
    {
      channel: ENV['RANDOM_CHANNEL_ID'],
      text: joke_text,
      thread_ts: ts
    }.to_json
  end
  
  context 'when the joke was successfully downloaded' do
    before do
      allow(DownloadJoke).to receive(:call).and_return(joke_text)
      allow(HTTParty).to receive(:post)
    end
  
    it 'sends the joke to the slack' do
      expect(HTTParty).to receive(:post).with(
        SendJoke::SEND_MESSAGE_URL,
        body: expected_body,
        headers: expected_headers
      ).once

      subject
    end
  end

  context 'when the joke could not be downloaded' do
    before do
      allow(DownloadJoke).to receive(:call).and_return(nil)
      allow(HTTParty).to receive(:post)
    end

    it 'does not send the joke to the slack' do
      expect(HTTParty).not_to receive(:post)
      subject
    end
  end
end