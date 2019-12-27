# frozen_string_literal: true

require 'ralyxa'

class CustomHandler

  attr_reader :http_request, :logger

  def initialize(application_id:, logger:)

    @logger = logger
  end

  def alexa
    @alexa ||= AlexaRuby.new(http_request, disable_validations: true)
  end

  WELCOME_MESSAGE = 'Willkommen zu Naturiv, ' \
      'deinem freundlichen Naturstein Inventur Helferlein.'.freeze
  SAVE_SUCCESS_MESSAGE = 'Danke, die Platte ist gespeichert.'.freeze

  def handle(http_request)
    @http_request = http_request

    puts request.inspect
    if type == :launch
      response.tell(WELCOME_MESSAGE)
    elsif type == :intent && request.intent_name == 'NewEntry'
      slots = {}
      request.slots.each do |slot|
        slots[slot.name.downcase.to_sym] = slot.value
      end

      spreadsheet_service.add_row(slots)

      response.tell(SAVE_SUCCESS_MESSAGE)
      card = {
        type: 'Standard', title: 'Platte gespeichert', content: SAVE_SUCCESS_MESSAGE
      }
      response.add_card(card)

    end


    response.json
  end

  def request
    alexa.request
  end

  def response
    alexa.response
  end

  def type
    request.type
  end

  def spreadsheet_service
    @spreadsheet_service ||= SpreadsheetService.new(ENV['SPREADSHEET_ID'])
  end
end
