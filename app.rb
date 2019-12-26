require 'sinatra'
require 'alexa_skills_ruby'

class CustomHandler < AlexaSkillsRuby::Handler

  on_intent("GetZodiacHoroscopeIntent") do
    slots = request.intent.slots
    response.set_output_speech_text("Horoscope Text")
    #response.set_output_speech_ssml("<speak><p>Horoscope Text</p><p>More Horoscope text</p></speak>")
    response.set_reprompt_speech_text("Reprompt Horoscope Text")
    #response.set_reprompt_speech_ssml("<speak>Reprompt Horoscope Text</speak>")
    response.set_simple_card("title", "content")
    logger.info 'GetZodiacHoroscopeIntent processed'
  end

end

get '/' do
  'hey'
end

post '/alexa/' do
  content_type :json

  handler = CustomHandler.new(application_id: ENV['APPLICATION_ID'],
                              logger: logger)

  begin
    hdrs = {
      'Signature' => request.env['HTTP_SIGNATURE'],
      'SignatureCertChainUrl' => request.env['HTTP_SIGNATURECERTCHAINURL']
    }
    handler.handle(request.body.read, hdrs)
  rescue AlexaSkillsRuby::Error => e
    logger.error e.to_s
    403
  end

end
