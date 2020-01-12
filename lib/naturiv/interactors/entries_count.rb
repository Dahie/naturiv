module Naturiv
  class EntriesCount
    include Interactor

    def call
      if has_saved_rows?
        context.voice_message = "Es wurden schon #{rows_count} Platten gespeichert."
        context.card_title = 'Anzahl gespeicherter Platten'
        context.card_message = "Es wurden schon #{rows_count} Platten gespeichert."
      else
        context.voice_message = 'Es wurde noch keine Platte angelegt.'
        context.card_title = 'Keine Platten gespeichert'
        context.card_message = 'Es wurde noch keine Platte angelegt.'
      end
    end

    private

    def has_saved_rows?
      rows_count > 1
    end

    def rows_count
      spreadsheet_service.rows_count
    end

    def spreadsheet_service
      @spreadsheet_service ||= Naturiv::SpreadsheetService.new(ENV['SPREADSHEET_ID'])
    end
  end
end
