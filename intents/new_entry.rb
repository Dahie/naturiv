SAVE_SUCCESS_MESSAGE = 'Danke, die Platte ist gespeichert.'.freeze

intent "NewEntry" do
  if request.confirmation_status == :confirmed
    slots = {
      material: request.slot_value('Material'),
      surface: request.slot_value('Surface'),
      thickness: request.slot_value('Thickness'),
      width: request.slot_value('Width'),
      length: request.slot_value('Length')
    }

    spreadsheet_service = SpreadsheetService.new(ENV['SPREADSHEET_ID'])
    spreadsheet_service.add_row(slots)

    card = card("Platte gespeichert", SAVE_SUCCESS_MESSAGE)
    respond(SAVE_SUCCESS_MESSAGE, card: card)
  else
    ask("Ok, die Platte wurde nicht gespeichert. Bitte gib sie noch einmal an.")
  end
end
