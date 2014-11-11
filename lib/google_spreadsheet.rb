require 'google_drive'

class GoogleSpreadsheet
  def initialize(key)
    session = GoogleDrive.login(ENV.fetch('GOOGLE_USER'), ENV.fetch('GOOGLE_PASSWORD'))
    @spreadsheet = session.spreadsheet_by_key(key)
  end

  def costs
    cost_amount_array_index = 1
    cost_amount_worksheet_column_index = 2

    worksheet = @spreadsheet.worksheets[0]
    cost_rows = worksheet.rows[1..-1]

    # Mitigate GoogleDrive::Worksheet#rows freezing
    # https://github.com/gimite/google-drive-ruby/blob/v0.3.10/lib/google_drive/worksheet.rb#L217-L227
    cost_rows = cost_rows.dup.map { |element| element.dup }

    row_num = 2 # Row/col are 1-origin, plus account for the header row
    cost_rows.each do |cost_row|
      cost_row[cost_amount_array_index] = worksheet.numeric_value(row_num, cost_amount_worksheet_column_index)
      row_num += 1
    end

    cost_rows
  end

  def people
    @spreadsheet.worksheets[1].rows[1..-1].map do |name, _|
      name
    end
  end

  def title
    @spreadsheet.title
  end
end
