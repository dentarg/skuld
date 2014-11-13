module DebtsHelper
  module_function

  def total_amount_to_get(debts, person)
    debts
      .select { |debt| debt[:payer] == person }
      .map    { |debt| debt[:amount] }
      .inject(0, :+).round
  end

  def total_amount_to_pay(debts, person)
    debts
      .select { |debt| debt[:sharer] == person }
      .map    { |debt| debt[:amount] }
      .inject(0, :+).round
  end
end
