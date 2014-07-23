require 'minitest/autorun'

$:.unshift File.join(File.dirname(__FILE__), '..', '..', 'lib')

require 'skuld'

class TestSkuld < MiniTest::Unit::TestCase
  def test_debt
    people = %w(Patrik Johan Roy)
    costs  = [
      ['Ballerina', 30.0, 'Patrik', 'Patrik, Johan, Roy'],
      ['Bregott',   12.0, 'Johan',  'Patrik, Johan, Roy'],
      ['Bärkasse',  50.0, 'Johan',  'Patrik, Roy'],
    ]

    skuld = Skuld.new(people, costs)

    assert_equal 29.0, skuld.debt(payer: 'Johan', sharer: 'Patrik')
  end

  def test_debt_with_alla
    people = %w(Patrik Johan Roy)
    costs  = [
      ['Ballerina', 30.0, 'Johan', 'Alla'],
      ['Bregott',   12.0, 'Johan', 'Patrik, Johan, Roy'],
      ['Bärkasse',  50.0, 'Johan', 'Patrik, Roy'],
    ]

    skuld = Skuld.new(people, costs)

    assert_equal 39.0, skuld.debt(payer: 'Johan', sharer: 'Patrik')
  end
end
