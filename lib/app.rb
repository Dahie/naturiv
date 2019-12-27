# frozen_string_literal: true

require 'sinatra'
require './lib/custom_handler'
require './lib/spreadsheet_service'

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
    handler.handle(body)
  rescue StandardError => e
    logger.error e.to_s
    403
  end
end
