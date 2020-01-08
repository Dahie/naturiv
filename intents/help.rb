# frozen_string_literal: true

intent 'AMAZON.HelpIntent' do
  success_message = "Naturiv ist zur Inventur von Natursteinplatten gedacht. " \
                     "Mit Befehlen wie 'Lege eine neue Platte an', kannst du einen neuen Eintrag beginnen. " \
                     "Ich werde dir dann weitere Fragen zur Größe und dem Material stellen. " \
                     "Am Ende wiederhole ich deine Eingabe und du kannst bestätigen, ob es richtig war. " \
                     "Wenn du mich fragst 'Was war die letzte Platte?' dann lese ich dir deine letzte gespeicherte Eingabe vor. " \
                     "Mit 'Wieviele Platten wurden schon gespeichert?' erfährst du wieviele insgesamt schon fertig angelegt wurden. "

  card = card('Hilfe zur Naturstein Inventur', success_message)
  respond(success_message, card: card)
end
