class ReportsController < ApplicationController
  layout "application"
  
  def index    
  end

  def spending_by_category
    @categories = Category.find(:all)    
  end

  def spending_by_payee 
    @payees = Payee.find(:all)        
  end
  
  def credit_card_debt 
    
  end
  
  def top_five_expense_categories 
    
  end
  
  def pending_transactions 
    
  end
end