require 'minitest/autorun'

$:.unshift File.join(File.dirname(__FILE__), '..', '..', 'lib')

require 'debts_helper'

class TestDebtsHelper < MiniTest::Unit::TestCase
  def debts
    [
      { payer: "Johan",   sharer: "Patrik", amount: 19.0 },
      { payer: "Patrik",  sharer: "Roy",    amount: 10.0 },
      { payer: "Johan",   sharer: "Roy",    amount: 29.0 }
    ]
  end

  def test_total_amount_to_get
    assert_equal 19.0+29.0, DebtsHelper.total_amount_to_get(debts, "Johan")
    assert_equal 10.0,      DebtsHelper.total_amount_to_get(debts, "Patrik")
  end

  def test_total_amount_to_pay
    assert_equal 10.0+29.0, DebtsHelper.total_amount_to_pay(debts, "Roy")
  end
end
