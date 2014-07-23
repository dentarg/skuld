require 'google_drive'

class GoogleSpreadsheet
  def initialize(key)
    session = GoogleDrive.login(ENV.fetch('GOOGLE_USER'), ENV.fetch('GOOGLE_PASSWORD'))
    @spreadsheet = session.spreadsheet_by_key(key)
  end

  def costs
    @spreadsheet.worksheet_by_title("Kostnader").rows[1..-1]
  end

  def people
    @spreadsheet.worksheet_by_title("Personer").rows[1..-1].flatten
  end
end
