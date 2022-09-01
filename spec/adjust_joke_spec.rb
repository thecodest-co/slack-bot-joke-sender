require 'spec_helper'

RSpec.describe AdjustJoke do
  subject(:context) { described_class.call(body: body) }

  let(:body) do
    {
      'type' => type,
      'setup' => setup,
      'delivery' => delivery,
      'joke' => joke
    }
  end

  let(:type) { nil }
  let(:joke) { nil } 
  let(:setup) { nil } 
  let(:delivery) { nil } 

  context 'when a single-line joke' do
    let(:type) { 'single' }
    let(:joke) { 'An example of a single-line joke' }
    let(:expected_joke) { joke }

    it "provides the joke_text" do
      expect(context.joke_text).to eq(expected_joke)
    end

    it "succeeds" do
      expect(context).to be_a_success
    end
  end

  context 'when returns a two-line joke' do
    let(:type) { 'twopart' }
    let(:setup) { 'First line of a joke' }
    let(:delivery) { 'Second line of a joke' }
    let(:expected_joke) { setup + "\n" + delivery }

    it "provides the joke_text" do
      expect(context.joke_text).to eq(expected_joke)
    end

    it "succeeds" do
      expect(context).to be_a_success
    end
  end
end