require 'spec_helper'

RSpec.describe 'send_joke' do
  subject { send_joke(event: nil, context: nil) }

  let(:send_joke_instance) { instance_double(SendJoke) }

  before do
    allow(SendJoke).to receive(:new).and_return(send_joke_instance)
    allow(send_joke_instance).to receive(:call).and_return('response')
  end

  it 'invokes a SendJoke service' do
    expect(send_joke_instance).to receive(:call).once
    subject
  end
end

RSpec.describe 'event_handler' do
  subject { event_handler(event: event, context: nil) }

  let(:send_joke_instance) { instance_double(SendJoke) }
  let(:event) { { 'body' => body } }
  let(:body) do
    {
      type: type,
      channel: channel,
      ts: ts
    }.to_json
  end

  let(:ts) { '123.456' }

  before do
    allow(SendJoke).to receive(:new).with(ts: ts).and_return(send_joke_instance)
    allow(send_joke_instance).to receive(:call).and_return('response')
  end

  context 'when the event is app_mention' do
    let(:type) { 'app_mention' }

    context 'when the channel is random' do
      let(:channel) { ENV['RANDOM_CHANNEL_ID'] }
      
      it 'invokes a SendJoke service' do
        expect(send_joke_instance).to receive(:call).once
        subject
      end

      it 'returns 200' do
        expect(subject).to eq({ statusCode: 200 })
      end
    end

    context 'when the channel is not random' do
      let(:channel) { 'other_channel_id' }
      
      it 'does not invoke a SendJoke service' do
        expect(send_joke_instance).not_to receive(:call)
        subject
      end

      it 'returns 200' do
        expect(subject).to eq({ statusCode: 200 })
      end
    end
  end

  context 'when the event is not app_mention' do
    let(:type) { 'other_event' }

    context 'when the channel is random' do
      let(:channel) { ENV['RANDOM_CHANNEL_ID'] }
      
      it 'does not invoke a SendJoke service' do
        expect(send_joke_instance).not_to receive(:call)
        subject
      end

      it 'returns 200' do
        expect(subject).to eq({ statusCode: 200 })
      end
    end

    context 'when the channel is not random' do
      let(:channel) { 'other_channel_id' }
      
      it 'does not invoke a SendJoke service' do
        expect(send_joke_instance).not_to receive(:call)
        subject
      end

      it 'returns 200' do
        expect(subject).to eq({ statusCode: 200 })
      end
    end
  end
end