require 'minitest/autorun'

$:.unshift File.join(File.dirname(__FILE__), '..', '..', 'lib')

require 'debts_helper'

class TestDebtsHelper < Minitest::Test
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

  def test_balances
    people = [
      "Johan",
      "Patrik",
      "Roy",
    ]

    expected_balances = [
      ["Johan",  48],
      ["Patrik", -9],
      ["Roy",    -39],
    ]

    assert_equal expected_balances,
      DebtsHelper.balances(debts: debts, people: people).map(&:to_a)
  end

  def balances
    data = [
      ["Patrik",    -2233],
      ["Johan",     1306],
      ["Thomas",    3059],
      ["Fredrik",   -479],
      ["Christian", -859],
      ["Jochim",    -794],
    ]

    data.map do |row|
      Balance.new(person: row[0], balance: row[1])
    end
  end

  def transactions
    data = [
      ["Patrik",    "Johan",  1306],
      ["Patrik",    "Thomas", 927],
      ["Fredrik",   "Thomas", 479],
      ["Christian", "Thomas", 859],
      ["Jochim",    "Thomas", 794],
    ]

    data.map do |row|
      from, to, amount = row
      Transaction.new(from: from, to: to, amount: amount)
    end
  end

  def test_calculate_transactions
    assert_equal transactions.sort, DebtsHelper.calculate_transactions(balances).sort
  end
end
