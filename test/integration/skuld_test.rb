require "minitest/autorun"
require "rack/test"

require_relative "../../skuld"

class SkuldTest < MiniTest::Unit::TestCase
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
end
