module TransactionsHelper
  def amount_column(record)
    number_to_currency(record.amount)
  end  
end
