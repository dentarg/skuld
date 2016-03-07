require "balance"
require "transaction"

module DebtsHelper
  module_function

  def total_amount_to_get(debts, person)
    debts
      .select { |debt| debt[:payer] == person }
      .map    { |debt| debt[:amount] }
      .inject(0, :+)
      .round
  end

  def total_amount_to_pay(debts, person)
    debts
      .select { |debt| debt[:sharer] == person }
      .map    { |debt| debt[:amount] }
      .inject(0, :+)
      .round
  end

  def balances(debts:, people:)
    people.map do |person|
      to_get = DebtsHelper.total_amount_to_get(debts, person)
      to_pay = DebtsHelper.total_amount_to_pay(debts, person)

      Balance.new(person: person, balance: to_get - to_pay)
    end.sort
  end

  def all_transactions(debts:, people:)
    calculate_transactions(balances(debts: debts, people: people))
  end

  def calculate_transactions(balances, transactions: [])
    a = balances.select { |person| person.balance > 0 }.
      min_by { |person| person.balance }
    b = balances.min_by { |person| person.balance }

    result = a.balance + b.balance

    if result < 0
      transactions << Transaction.new(from: b.person, to: a.person, amount: a.balance)

      a.balance = 0
      b.balance = result

      return transactions if result == -1

      calculate_transactions(balances, transactions: transactions)
    elsif result >= 0
      transactions << Transaction.new(from: b.person, to: a.person, amount: -b.balance)

      a.balance = result
      b.balance = 0

      return transactions if [0, 1].include?(result)

      calculate_transactions(balances, transactions: transactions)
    end
  end
end
