require 'spec_helper'

RSpec.describe DownloadJoke do
  subject(:context) { described_class.call }

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

    it "succeeds" do
      expect(context).to be_a_success
    end

    let(:expected_body) { JSON.parse(response.body) }

    it "provides the body" do
      expect(context.body).to eq(expected_body)
    end
  end

  context 'when an external service returns error' do
    let(:code) { 200 }
    let(:error) { true }
  
    it 'fails' do
      expect(context).to be_a_failure
    end

    it "provides a failure message" do
      expect(context.error).not_to be_nil
    end
  end

  context 'when an external service does not return code 200' do
    let(:code) { 404 }
    let(:error) { false }
  
    it 'fails' do
      expect(context).to be_a_failure
    end

    it "provides a failure message" do
      expect(context.error).not_to be_nil
    end
  end
end