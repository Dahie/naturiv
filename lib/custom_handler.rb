# frozen_string_literal: true

require 'alexa_skills_ruby'

class CustomHandler < AlexaSkillsRuby::Handler
  on_launch do
    response.set_output_speech_text(
      'Willkommen zu Naturiv, ' \
      'deinem freundlichen Naturstein Inventur Helferlein.'
    )
  end

  on_intent('NewEntry') do
    # slots = request.intent.slots

    response.set_output_speech_text('Danke, die Platte ist gespeichert.')
    # response.set_output_speech_ssml(
    #  "<speak><p>Horoscope Text</p><p>More Horoscope text</p></speak>")
    response.set_reprompt_speech_text('Reprompt Horoscope Text')
    # response.set_reprompt_speech_ssml(
    #  "<speak>Reprompt Horoscope Text</speak>")
    logger.info 'NewEntryIntent processed'
  end

  on_intent('HelpIntent') do
    response.set_output_speech_text('Ich helfe noch gar nischt!')
  end

  def spreadsheet_service
    @spreadsheet_service ||= SpreadsheetService.new(ENV['SPREADSHEET_ID'])
  end
end
