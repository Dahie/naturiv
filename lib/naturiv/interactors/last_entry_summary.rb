module Naturiv
  class LastEntrySummary
    include Interactor

    def call
      if has_saved_rows?
        context.voice_message = "Die letzte Platte wurde am #{record_created_at} gespeichert. " \
                          "Sie ist #{latest_record.surface} aus #{latest_record.material}. " \
                          "Größe beträgt #{latest_record.width}cm zu #{latest_record.length}cm " \
                          "und ist #{latest_record.thickness}cm stark. "
        context.card_title = 'Letzte gespeicherte Platte'
        context.card_message = "Gespeichert am #{record_created_at}\n" \
                    "Material: #{latest_record.material} (#{latest_record.surface})\n" \
                    "Größe: #{latest_record.width}cm x #{latest_record.length}cm\n" \
                    "bei #{latest_record.thickness}cm Stärke"
      else
        context.voice_message = 'Es wurde noch keine Platte angelegt.'
        context.card_title = 'Keine Platten gespeichert'
        context.card_message = 'Es wurde noch keine Platte angelegt.'
      end
    end

    private

    def has_saved_rows?
      spreadsheet_service.rows_count > 1
    end

    def latest_record
      spreadsheet_service.last_row
    end

    def record_created_at
      latest_record.formatted_created_at
    end

    def spreadsheet_service
      @spreadsheet_service ||= Naturiv::SpreadsheetService.new(ENV['SPREADSHEET_ID'])
    end
  end
end
