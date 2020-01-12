# frozen_string_literal: true

require 'erb'
require 'google_drive'

COLUMN_MAPPING = %w[material surface thickness width length amount].freeze

module Naturiv
  class SpreadsheetService
    attr_reader :spreadsheet_id

    def initialize(spreadsheet_id)
      @spreadsheet_id = spreadsheet_id
    end

    def add_row(record)
      row_index = rows_count + 1
      COLUMN_MAPPING.each_with_index do |datafield, index|
        col_index = index + 1
        fill_value(row_index, col_index, record.send(datafield))
      end

      fill_value(row_index, 7, '')
      fill_value(row_index, 8, Time.now)
      worksheet.save
    end

    def fill_value(row_index, col_index, value)
      worksheet[row_index, col_index] = value
    end

    def last_row
      row = worksheet.rows.last
      Record.new.tap do |record|
        record.material = row[0]
        record.surface = row[1]
        record.thickness = row[2]
        record.width = row[3]
        record.length = row[4]
        record.amount = row[5]
        record.comment = row[6]
        record.created_at = row[7]
      end
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

    def config
      OpenStruct.new(save: true,
                     client_id: ENV['DRIVE_CLIENT_ID'],
                     client_secret: ENV['DRIVE_CLIENT_SECRET'],
                     scope: [
                       'https://www.googleapis.com/auth/drive',
                       'https://spreadsheets.google.com/feeds/'
                     ],
                     refresh_token: ENV['DRIVE_REFRESH_TOKEN'])
    end

    def session
      @session ||= GoogleDrive::Session.from_config(config)
    end
  end
end
