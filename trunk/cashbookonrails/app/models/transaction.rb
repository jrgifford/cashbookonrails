class Transaction < ActiveRecord::Base
  belongs_to :account

  validates_presence_of :amount, :account_id
  validates_format_of :amount, :with => /^[0-9]+\.[0-9]{0,2}$/
  validates_numericality_of :amount, :greater_than => 0.0

  def name
    "#{number} - #{payee_category}"  
  end

  def real_amount
    self.credit ? self.amount : self.amount * -1
  end    
end
