require 'spec_helper'

RSpec.describe SendJoke do
  it { expect(described_class.organized).to eq([DownloadJoke, AdjustJoke, SendMessage]) }
end