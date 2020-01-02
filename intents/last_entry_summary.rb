# frozen_string_literal: true

intent 'LastEntrySummary' do
  spreadsheet_service = SpreadsheetService.new(ENV['SPREADSHEET_ID'])
  if spreadsheet_service.rows_count > 1
    record = spreadsheet_service.last_row

    puts record.inspect

    created_at = record.formatted_created_at

    success_message = "Die letzte Platte wurde am #{created_at} gespeichert. " \
                      "Sie ist #{record.surface} aus #{record.material}. " \
                      "Größe beträgt #{record.width}cm zu #{record.length}cm " \
                      "und #{record.thickness}cm stark. "

    card_text = "Gespeichert am #{created_at}\n" \
                "Material: #{record.material} (#{record.surface})\n" \
                "Größe: #{record.width}cm x #{record.height}cm \n" \
                "bei #{record.thickness}cm Stärke"

    card = card('Letzte gespeicherte Platte', card_text)
    respond(success_message, card: card)
  else
    ask('Ok, die Platte wurde nicht gespeichert. Bitte gib sie noch einmal an.')
  end
end
