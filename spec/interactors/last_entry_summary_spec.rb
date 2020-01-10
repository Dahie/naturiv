require 'naturiv'

RSpec.describe Naturiv::LastEntrySummary do
  describe '.call' do
    it 'delegates finding a movie to an Imdb client search' do
      client = double("Imdb::Search")
      expect(client).to receive_message_chain(:new, :movies, :first)

      described_class.find("Some Movie Title", client)
    end
  end
end
