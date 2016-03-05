class Transaction
  include Comparable

  attr_accessor :from, :to, :amount

  def initialize(from:, to:, amount:)
    @from   = from
    @to     = to
    @amount = amount
  end

  def <=>(other)
    [from, to, amount] <=> [other.from, other.to, other.amount]
  end
end
