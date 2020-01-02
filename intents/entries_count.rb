# frozen_string_literal: true

intent 'EntriesCount' do
  spreadsheet_service = SpreadsheetService.new(ENV['SPREADSHEET_ID'])
  count = spreadsheet_service.rows_count - 1
  if count > 1
    success_message = "Es wurden schon #{count} Platten gespeichert."
    card_text = "Es wurden schon #{count} Platten gespeichert."

    card = card('Anzahl gespeicherter Platten', card_text)
    respond(success_message, card: card)
  else
    respond('Es wurde noch keine Platte angelegt.')
  end
end
