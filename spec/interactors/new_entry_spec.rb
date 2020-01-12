require 'naturiv'

RSpec.describe Naturiv::NewEntry do

  describe '.call' do
    let(:alexa_request) do
      double(:request,
             confirmation_status: confirmation_status)
    end
    let(:spreadsheet_service) { double(:spreadsheet_service) }
    subject(:call) { described_class.call(alexa_request: alexa_request) }

    before do
      allow(Naturiv::SpreadsheetService)
        .to receive(:new).and_return(spreadsheet_service)
      allow(spreadsheet_service).to receive(:add_row)

      allow(alexa_request)
        .to receive(:slot_value)
        .and_return('Balmoral', 'poliert', 3, 100, 150, 2)
    end

    context 'input not confirmed' do
      let(:confirmation_status) { :declined }

      it do
        expect(call.voice_message).to eql 'Ok, die Platte wurde nicht gespeichert. Bitte gib sie noch einmal an.'
      end

      it do
        expect(call.card_title).to eql 'Platte nicht gespeichert'
      end

      it do
        expect(call.card_message).to eql 'Ok, die Platte wurde nicht gespeichert. Bitte gib sie noch einmal an.'
      end
    end

    context 'input confirmed' do
      let(:confirmation_status) { :confirmed }

      it 'persists a new entry in spreadsheet' do
        call
        expect(spreadsheet_service).to have_received(:add_row)
      end

      it do
        expect(call.voice_message).to eql 'Danke, die Platte ist gespeichert.'
      end

      it do
        expect(call.card_title).to eql 'Platte gespeichert'
      end

      it do
        expect(call.card_message).to eql 'Danke, die Platte ist gespeichert.'
      end
    end

  end
end
