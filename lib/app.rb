# frozen_string_literal: true

require 'sinatra'
require 'ralyxa'
require './lib/spreadsheet_service'

get '/' do
  'hey, naturiv is alive'
end

post '/' do
  Ralyxa::Skill.handle(request)
end
