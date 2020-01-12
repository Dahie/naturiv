# frozen_string_literal: true

intent 'EntriesCount' do
  result = EntriesCount.call

  card = card(result.card_title, result.card_message)
  respond(result.voice_message, card: card)
end
