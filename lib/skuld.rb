require 'cost'

class Skuld
  def initialize(people, cost_rows)
    @people = people
    costs   = cost_rows.map { |cost_row| Cost.new(cost_row) }
    @costs  = filter_costs(costs)
  end

  def filter_costs(costs)
    costs.reject { |cost| cost.amount == nil }
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

  def all_debts
    combinations = @people.combination(2).to_a

    debts = combinations.map do |combination|
      payer, sharer = combination
      first = {
        payer:  payer,
        sharer: sharer,
        amount: debt(payer: payer, sharer: sharer)
      }

      payer, sharer = combination.reverse
      second = {
        payer:  payer,
        sharer: sharer,
        amount: debt(payer: payer, sharer: sharer)
      }

      self.class.settle_debt(first, second)
    end

    debts.select { |debt| debt[:amount] != 0 }
  end

  def self.settle_debt(first, second)
    first_minus_second = first[:amount] - second[:amount]
    second_minus_first = second[:amount] - first[:amount]

    if first_minus_second >= 0
      first[:amount] = first_minus_second
      first
    elsif second_minus_first > 0
      second[:amount] = second_minus_first
      second
    end
  end
end
