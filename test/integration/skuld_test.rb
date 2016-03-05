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

  # API key needed
  # def test_demo
  #   get "/1GQFvsrwWDAhVFwIMV3ClHwxDGKnLskgicdhc1RqXxVg"
  #   assert last_response.ok?
  # end
end
