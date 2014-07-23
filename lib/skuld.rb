require 'cost'

class Skuld
  def initialize(people, cost_rows)
    @people = people
    @costs  = cost_rows.map { |cost_row| Cost.new(cost_row) }
  end

  def debt(payer:, sharer:)
    debt = 0

    @costs.each do |cost|
      conditions = [
        cost.payer == payer,
        cost.sharer_should_pay?(sharer),
      ]

      if conditions.all?
        debt += amount_per_sharer(cost)
      end
    end

    debt
  end

  def amount_per_sharer(cost)
    if cost.sharers.include?('Alla')
      cost.amount / @people.count
    else
      cost.amount / cost.sharers.count
    end
  end
end
