require 'minitest/autorun'

$:.unshift File.join(File.dirname(__FILE__), '..', '..', 'lib')

require 'cost'

class TestCost < MiniTest::Unit::TestCase
  def test_cost
    cost_row = ['Ballerina', 30.0, 'Patrik', 'Patrik, Johan, Roy']
    cost     = Cost.new(cost_row)

    assert_equal 'Ballerina',           cost.description
    assert_equal 30.0,                  cost.amount
    assert_equal 'Patrik',              cost.payer
    assert_equal %w(Patrik Johan Roy),  cost.sharers
  end
end
