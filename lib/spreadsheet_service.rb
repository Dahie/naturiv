# frozen_string_literal: true

require 'google_drive'

class SpreadsheetService
  attr_reader :spreadsheet_id

  def initialize(spreadsheet_id)
    @spreadsheet_id = spreadsheet_id
  end

  def add_row(material: '', surface: '', thickness: '', width: '', length: '')
    new_row_index = rows_count + 1
    fill_value(new_row_index, 1, material)
    fill_value(new_row_index, 2, surface)
    fill_value(new_row_index, 3, thickness)
    fill_value(new_row_index, 4, width)
    fill_value(new_row_index, 5, length)
    fill_value(new_row_index, 6, '')
    fill_value(new_row_index, 7, Time.zone.now)
    worksheet.save
  end

  def fill_value(row_index, col_index, value)
    worksheet[row_index, col_index] = value
  end

  def worksheet
    @worksheet ||= spreadsheet.worksheets[0]
  end

  def rows_count
    worksheet.rows.count
  end

  def spreadsheet
    @spreadsheet ||= session.spreadsheet_by_key(spreadsheet_id)
  end

  def config_file
    ERB.new(File.read('config.yml')).result
  end

  def session
    @session ||= GoogleDrive::Session.from_config(config_file)
  end
end
