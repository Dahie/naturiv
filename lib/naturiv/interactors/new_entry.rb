module Naturiv
  class NewEntry
    include Interactor

    def call
      if input_confirmed?
        persist_record

        context.voice_message = 'Danke, die Platte ist gespeichert.'
        context.card_title = 'Platte gespeichert'
        context.card_message = 'Danke, die Platte ist gespeichert.'
      else
        context.voice_message = 'Ok, die Platte wurde nicht gespeichert. ' \
                                'Bitte gib sie noch einmal an.'
        context.card_title = 'Platte nicht gespeichert'
        context.card_message = 'Ok, die Platte wurde nicht gespeichert. ' \
                                'Bitte gib sie noch einmal an.'
      end
    end

    private

    def persist_record
      record.material = slot_value('Material')
      record.surface = slot_value('Surface')
      record.thickness = slot_value('Thickness')
      record.width = slot_value('Width')
      record.length = slot_value('Length')
      record.amount = slot_value('Amount')

      spreadsheet_service.add_row(record)
    end

    def record
      @record ||= Record.new
    end

    def alexa_request
      context.alexa_request
    end

    def input_confirmed?
      alexa_request.confirmation_status == :confirmed
    end

    def slot_value(key)
      alexa_request.slot_value(key)
    end

    def spreadsheet_service
      @spreadsheet_service ||= Naturiv::SpreadsheetService.new(ENV['SPREADSHEET_ID'])
    end
  end
end
