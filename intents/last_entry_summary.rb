# frozen_string_literal: true

intent 'LastEntrySummary' do
  result = LastEntrySummary.call
  card = card(card.card_title, result.card_message)
  respond(result.voice_message, card: card)
end
