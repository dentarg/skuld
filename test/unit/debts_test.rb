require 'minitest/autorun'

$:.unshift File.join(File.dirname(__FILE__), '..', '..', 'lib')

require 'debts'

class TestDebts < MiniTest::Unit::TestCase
  def test_debt
    people = %w(Patrik Johan Roy)
    costs  = [
      ['Ballerina', 30.0, 'Patrik', 'Patrik, Johan, Roy'],
      ['Bregott',   12.0, 'Johan',  'Patrik, Johan, Roy'],
      ['Bärkasse',  50.0, 'Johan',  'Patrik, Roy'],
    ]

    debts = Debts.new(people, costs)

    assert_equal 29.0, debts.debt_between(payer: 'Johan', sharer: 'Patrik')
  end

  def test_debt_with_incomplete_data_no_cost_amount
    people = %w(Patrik Johan Roy)
    costs  = [
      ['Kaffe',     nil,  'Johan',  'Johan, Patrik'],
      ['Ballerina', 30.0, 'Patrik', 'Patrik, Johan, Roy'],
      ['Bregott',   12.0, 'Johan',  'Patrik, Johan, Roy'],
      ['Bärkasse',  50.0, 'Johan',  'Patrik, Roy'],
    ]

    debts = Debts.new(people, costs)

    assert_equal 29.0, debts.debt_between(payer: 'Johan', sharer: 'Patrik')
  end

  def test_debt_with_alla
    people = %w(Patrik Johan Roy)
    costs  = [
      ['Ballerina', 30.0, 'Johan', 'Alla'],
      ['Bregott',   12.0, 'Johan', 'Patrik, Johan, Roy'],
      ['Bärkasse',  50.0, 'Johan', 'Patrik, Roy'],
    ]

    debts = Debts.new(people, costs)

    assert_equal 39.0, debts.debt_between(payer: 'Johan', sharer: 'Patrik')
  end

  def test_settle_debt
    first = {
      payer:  'Patrik',
      sharer: 'Johan',
      amount: 10,
    }

    second = {
      payer:  'Johan',
      sharer: 'Patrik',
      amount: 29,
    }

    expected_debt = {
      payer:  'Johan',
      sharer: 'Patrik',
      amount: 19,
    }

    settled_debt = Debts.settle_debt(first, second)

    assert_equal expected_debt, settled_debt
  end

  def test_settle_even_debt
    first = {
      payer:  'Patrik',
      sharer: 'Johan',
      amount: 10,
    }

    second = {
      payer:  'Johan',
      sharer: 'Patrik',
      amount: 10,
    }

    expected_debt = {
      payer:  'Patrik',
      sharer: 'Johan',
      amount: 0,
    }

    settled_debt = Debts.settle_debt(first, second)

    assert_equal expected_debt, settled_debt
  end
end
