require 'naturiv'

RSpec.describe Naturiv::EntriesCount do

  describe '.call' do
    subject(:call) { described_class.call }

    before do
      allow(Naturiv::SpreadsheetService)
        .to receive(:new)
        .and_return double(rows_count: rows_count)
    end

    context 'no entries stored' do
      let(:rows_count) { 1 }

      it do
        expect(call.voice_message).to eql 'Es wurde noch keine Platte angelegt.'
      end

      it do
        expect(call.card_title).to eql 'Keine Platten gespeichert'
      end

      it do
        expect(call.card_message).to eql 'Es wurde noch keine Platte angelegt.'
      end
    end

    context '2 entries stored' do
      let(:rows_count) { 3 }
      let(:record1) { }
      let(:record2) { }

      it do
        expect(call.voice_message).to eql 'Es wurden schon 3 Platten gespeichert.'
      end

      it do
        expect(call.card_title).to eql 'Anzahl gespeicherter Platten'
      end

      it do
        expect(call.card_message).to eql 'Es wurden schon 3 Platten gespeichert.'
      end
    end
  end
end
