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

  def inspect
    vars = "@person=#{person}, @balance=#{balance}"

    sprintf("#<%s:0x%x %s>", self.class.name, __id__, vars)
  end
end
