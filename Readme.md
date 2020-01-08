# Naturiv - Spoken Inventory Skill for Alexa

An application using Sinatra and the [Ralyxa](https://github.com/sjmog/ralyxa) gem.
I build this within 2 days to support my father's company in their inventory process.

## Setup for Development

1. Run `bundle install` to install project dependencies.
2. Use ngrok using `./ngrok http 4567` (replace `4567` with whichever port you have configured Sinatra to use) to expose a development server backend for Alexa
3. Set up an Alexa skill pointing to your ngrok HTTPS endpoint.


## Playing with the example

You can do five things:

1. "Starte Naturstein Inventur"
2. "Lege eine neue Natursteinplatte an"
3. "Erkläre mir wie das funktioniert"
4. "Was war die letzte gespeicherte Platte?"
5. "Wieviele Platten wurden bereits angelegt?"
