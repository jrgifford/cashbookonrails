module AccountsHelper
  def total_column(record)
    number_to_currency(record.total)
  end  
end
