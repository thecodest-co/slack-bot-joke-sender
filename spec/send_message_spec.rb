require 'spec_helper'

RSpec.describe SendMessage do
  subject(:context) { described_class.call(ts: ts, joke_text: joke_text) }

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
  
  before do
    allow(HTTParty).to receive(:post)
  end

  context 'when ts is not nil' do
    let(:ts) { '123.456' }
  
    it "succeeds" do
      expect(context).to be_a_success
    end

    it 'sends the joke to the slack' do
      expect(HTTParty).to receive(:post).with(
        SendMessage::SEND_MESSAGE_URL,
        body: expected_body,
        headers: expected_headers
      ).once

      subject
    end
  end

  context 'when ts is nil' do
    let(:ts) { nil }
  
    it "succeeds" do
      expect(context).to be_a_success
    end

    it 'sends the joke to the slack' do
      expect(HTTParty).to receive(:post).with(
        SendMessage::SEND_MESSAGE_URL,
        body: expected_body,
        headers: expected_headers
      ).once

      subject
    end
  end

end