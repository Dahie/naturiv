# frozen_string_literal: true

require 'sinatra'
require 'ralyxa'
require 'interactor'
require './lib/naturiv/record'
require './lib/naturiv/interactors/entries_count'
require './lib/naturiv/interactors/last_entry_summary'
require './lib/naturiv/interactors/new_entry'
require './lib/naturiv/spreadsheet_service'

get '/' do
  'hey, naturiv is alive'
end

post '/' do
  Ralyxa::Skill.handle(request)
end
