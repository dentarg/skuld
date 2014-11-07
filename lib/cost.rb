class Cost
  attr_reader :description, :amount, :payer, :sharers

  def initialize(cost_row)
    @description        = cost_row[0]
    @amount             = cost_row[1]
    @payer              = cost_row[2]
    @sharers            = cost_row[3].split(',').map(&:strip)
  end

  def sharer_should_pay?(sharer)
    return true if sharers.include?(sharer)
    return true if sharers.include?('Alla')
    false
  end
end
