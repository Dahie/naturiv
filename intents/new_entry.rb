# frozen_string_literal: true

intent 'NewEntry' do
  result = Naturiv::NewEntry.call(alex_request: request)

  card = card(result.card_title, result.card_message)
  respond(result.voice_message, card: card)
end
