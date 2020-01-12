require 'naturiv'

RSpec.describe Naturiv::LastEntrySummary do

  describe '.call' do
    subject(:call) { described_class.call }
    let(:spreadsheet_service) do
      double(:spreadsheet_service, last_row: record)
    end
    let(:record) { nil }

    before do
      allow(Naturiv::SpreadsheetService)
        .to receive(:new).and_return(spreadsheet_service)
      allow(spreadsheet_service).to receive(:rows_count).and_return(rows_count)
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
      let(:rows_count) { 2 }
      let(:record) do
        Record.new.tap do |record|
          record.material = 'Balmoral'
          record.surface = 'poliert'
          record.thickness = 2
          record.width = 100
          record.length = 150
          record.amount = 2
          record.comment = ''
          record.created_at = Time.now.to_s
        end
      end
      let(:expected_card_message) do
        "Gespeichert am #{record.formatted_created_at}\n" \
         "Material: #{record.material} (#{record.surface})\n" \
         "Größe: #{record.width}cm x #{record.length}cm\n" \
         "bei #{record.thickness}cm Stärke"
      end

      it do
        expect(call.voice_message).to eql "Die letzte Platte wurde am #{record.formatted_created_at} gespeichert. Sie ist #{record.surface} aus #{record.material}. Größe beträgt #{record.width}cm zu #{record.length}cm und ist #{record.thickness}cm stark. "
      end

      it do
        expect(call.card_title).to eql "Letzte gespeicherte Platte"
      end

      it do
        expect(call.card_message).to eql expected_card_message
      end
    end
  end
end
