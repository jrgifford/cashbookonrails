class Bill < ActiveRecord::Base
  PAYMENT_METHODS = [
    # Displayed           stored in db
    [ "Check" ,           "ck" ],
    [ "Credit card" ,     "cc" ],
    [ "Cash" ,            "cs" ]
  ]
  
  FREQUENCY = [
    # Displayed      stored in db
    [ "Only once" ,    "mm" ],
    [ "Daily" ,     "ya" ],
    [ "Weekly" ,  "tt" ],
    [ "Monthly" ,  "tt" ],
    [ "Twice a month" ,  "tt" ],
    [ "Yearly" ,  "tt" ],
    [ "Twice a year" ,  "tt" ]
  ]  
  
  belongs_to :payee
  belongs_to :account
  belongs_to :category

  validates_presence_of :payee_id, :account_id, :next_payment_date, :payment_method, :frequency, :amount, :category_id
  validates_format_of :amount, :with => /^[0-9]+\.[0-9]{0,2}$/
  validates_numericality_of :amount, :greater_than => 0.0
  validates_inclusion_of :payment_method, :in => PAYMENT_METHODS.map {|disp, value| value}
  validates_inclusion_of :frequency, :in => FREQUENCY.map {|disp, value| value}

  def name
    "#{number} - #{payee.name}"  
  end

  def real_amount
    self.category.credit ? self.amount : self.amount * -1
  end

  def pay
    transaction = Transaction.new
    transaction.date = self.next_payment_date
    transaction.number = self.number
    transaction.payee_category = self.payee.name
    transaction.amount = self.amount
    transaction.credit = self.category.credit
    transaction.account = self.account
    transaction.save
  end    
end
