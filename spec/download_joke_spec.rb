require 'spec_helper'

RSpec.describe DownloadJoke do
  subject { described_class.call }

  let(:response) { double(:response, code: code, body: body)}
  let(:body) do
    {
      error: error,
      type: type,
      setup: setup,
      delivery: delivery,
      joke: joke
    }.to_json
  end

  let(:type) { nil }
  let(:joke) { nil } 
  let(:setup) { nil } 
  let(:delivery) { nil } 

  before do
    allow(HTTParty).to receive(:get).with(DownloadJoke::JOKES_API_URL).and_return(response)
  end

  context 'when an external service returns code 200 without error' do
    let(:code) { 200 }
    let(:error) { false }

    context 'when returns a single-line joke' do
      let(:type) { 'single' }
      let(:joke) { 'An example of a single-line joke' }

      it 'makes GET request to an extenal service' do
        expect(HTTParty).to receive(:get).with(DownloadJoke::JOKES_API_URL).once
        subject
      end

      it 'returns a single-line joke' do
        expect(subject).to eq(joke)
      end
    end

    context 'when returns a two-line joke' do
      let(:type) { 'twopart' }
      let(:setup) { 'First line of a joke' }
      let(:delivery) { 'Second line of a joke' }
      let(:expected_result) { setup + "\n" + delivery }

      it 'makes GET request to an extenal service' do
        expect(HTTParty).to receive(:get).with(DownloadJoke::JOKES_API_URL).once
        subject
      end

      it 'returns a single-line joke' do
        expect(subject).to eq(expected_result)
      end
    end
  end

  context 'when an external service returns error' do
    let(:code) { 200 }
    let(:error) { true }
  
    it 'returns nil' do
      expect(subject).to eq(nil)
    end
  end

  context 'when an external service does not return code 200' do
    let(:code) { 404 }
    let(:error) { false }
  
    it 'returns nil' do
      expect(subject).to eq(nil)
    end
  end
end