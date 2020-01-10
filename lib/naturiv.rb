# frozen_string_literal: true

require 'sinatra'
require 'ralyxa'
require './lib/naturiv/record'
require './lib/naturiv/interactors/last_entry_summary'
require './lib/naturiv/spreadsheet_service'

get '/' do
  'hey, naturiv is alive'
end

post '/' do
  Ralyxa::Skill.handle(request)
end
