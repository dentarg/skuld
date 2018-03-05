require "minitest/autorun"
require "rack/test"

require_relative "../../skuld"

class SkuldTest < Minitest::Test
  include Rack::Test::Methods

  def app
    Skuld.new
  end

  def test_root
    get "/"
    assert last_response.ok?
  end

  def test_test
    get "/test"
    assert last_response.ok?
  end

  # Needs the following ENV vars to be configured
  # * GOOGLE_SERVICE_ACCOUNT_ID
  # * GOOGLE_SERVICE_ACCOUNT_PRIVATE_KEY
  def test_demo
    get "/1GQFvsrwWDAhVFwIMV3ClHwxDGKnLskgicdhc1RqXxVg"
    assert last_response.ok?
    assert last_response.body.include?("skuld demo")
  end
end
