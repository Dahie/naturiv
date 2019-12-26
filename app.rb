# frozen_string_literal: true

require 'sinatra'
require 'alexa_skills_ruby'

class CustomHandler < AlexaSkillsRuby::Handler
  on_launch do
    response.set_output_speech_text(
      'Willkommen zu Naturiv, ' \
      'deinem freundlichen Naturstein Inventur Helferlein.'
    )
  end

  on_intent('NewEntry') do
    slots = request.intent.slots

    puts slots.inspect

    response.set_output_speech_text('Danke, die Platte ist gespeichert.')
    # response.set_output_speech_ssml(
    #  "<speak><p>Horoscope Text</p><p>More Horoscope text</p></speak>")
    response.set_reprompt_speech_text('Reprompt Horoscope Text')
    # response.set_reprompt_speech_ssml(
    #  "<speak>Reprompt Horoscope Text</speak>")
    logger.info 'NewEntryIntent processed'

    puts session_attributes.inspect
    session_attributes['started_at'] = Time.zone.now
  end

  on_intent('HelpIntent') do
    response.set_output_speech_text('Ich helfe noch gar nischt!')
  end
end

get '/' do
  'hey, naturiv is alive'
end

post '/' do
  content_type :json

  hdrs = {
    'Signature' => request.env['HTTP_SIGNATURE'],
    'SignatureCertChainUrl' => request.env['HTTP_SIGNATURECERTCHAINURL']
  }

  application_id = ENV['APPLICATION_ID']

  handler = CustomHandler.new(application_id: application_id,
                              logger: logger)
  body = request.body.read

  begin
    handler.handle(body, hdrs)
  rescue AlexaSkillsRuby::Error => e
    logger.error e.to_s
    403
  end
end
