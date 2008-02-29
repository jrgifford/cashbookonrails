module BillsHelper
  # display the "payment_method" field as a dropdown instead of a texfield
  def payment_method_form_column(record, input_name)
    select :record, :payment_method, Bill::PAYMENT_METHODS
  end
  
  # display the "payment_method" field as a dropdown instead of a texfield
  def frequency_form_column(record, input_name)
    select :record, :frequency, Bill::FREQUENCY
  end  
  
  def amount_column(record)
    number_to_currency(record.amount)
  end
end
