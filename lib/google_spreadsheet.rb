require 'google_drive'

class GoogleSpreadsheet
  def initialize(key)
    session = GoogleDrive.login(ENV.fetch('GOOGLE_USER'), ENV.fetch('GOOGLE_PASSWORD'))
    @spreadsheet = session.spreadsheet_by_key(key)
  end

  def costs
    @spreadsheet.worksheets[0].rows[1..-1]
  end

  def people
    @spreadsheet.worksheets[1].rows[1..-1].flatten
  end

  def title
    @spreadsheet.title
  end
end
