# frozen_string_literal: true

SAVE_SUCCESS_MESSAGE = 'Danke, die Platte ist gespeichert.'

intent 'NewEntry' do
  if request.confirmation_status == :confirmed
    record = Record.new
    record.material = request.slot_value('Material')
    record.surface = request.slot_value('Surface')
    record.thickness = request.slot_value('Thickness')
    record.width = request.slot_value('Width')
    record.length = request.slot_value('Length')
    record.amount = request.slot_value('Amount')

    spreadsheet_service = SpreadsheetService.new(ENV['SPREADSHEET_ID'])
    spreadsheet_service.add_row(record)

    card = card('Platte gespeichert', SAVE_SUCCESS_MESSAGE)
    respond(SAVE_SUCCESS_MESSAGE, card: card)
  else
    ask('Ok, die Platte wurde nicht gespeichert. Bitte gib sie noch einmal an.')
  end
end
