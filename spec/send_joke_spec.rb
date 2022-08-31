require 'spec_helper'

RSpec.describe SendJoke do
  subject(:context) { described_class.new.call }

  it { expect(described_class.organized).to eq([DownloadJoke, AdjustJoke, SendMessage]) }
end