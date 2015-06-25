require "google/api_client"
require "google_drive"

class GoogleSpreadsheet
  def initialize(document_key)
    private_key = ENV.fetch("GOOGLE_SERVICE_ACCOUNT_PRIVATE_KEY")
    service_id  = ENV.fetch("GOOGLE_SERVICE_ACCOUNT_ID")
    scopes      = ['https://www.googleapis.com/auth/drive.readonly']

    client      = Google::APIClient.new(application_name: "skuld", application_version: "1.0")
    key         = OpenSSL::PKey::RSA.new(private_key, "notasecret")
    asserter    = Google::APIClient::JWTAsserter.new(service_id, scopes, key)

    client.authorization = asserter.authorize

    session = GoogleDrive.login_with_oauth(client.authorization.access_token)
    @spreadsheet = session.spreadsheet_by_key(document_key)
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
