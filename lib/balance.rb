class Balance
  include Comparable

  attr_accessor :person, :balance

  def initialize(person:, balance:)
    @person  = person
    @balance = balance
  end

  def <=>(other)
    other.balance <=> balance
  end

  def to_a
    [person, balance]
  end
end
