class Account < ActiveRecord::Base
  has_many :transactions
  has_many :bills

  validates_presence_of :name, :number

  def total
    total_credit = 0
    total_debit = 0

    total_credit = self.transactions.sum(:amount, :conditions => {:credit => true}).to_f
    total_debit = self.transactions.sum(:amount, :conditions => {:credit => false}).to_f
    total_credit - total_debit
  end  
end
