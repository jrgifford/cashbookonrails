require File.dirname(__FILE__) + '/../test_helper'

class AccountTest < ActiveSupport::TestCase
  def setup
    account_default_values = {
            :id => 1,
            :name => "Checking",
            :number => "45042-1"
            }
    @account = Account.new(account_default_values)    
  end

  def test_create_valid_record
    assert @account.valid?, "Account is invalid:\n#{@account.to_yaml}"
  end

  def test_cant_create_without_obrigatory_fields
    @account.name = @account.number = ""
    assert (not @account.valid?)
    assert_not_nil @account.errors.on(:name)
    assert_not_nil @account.errors.on(:number)
  end

  def test_total_amount_in_the_account
    checking = Account.find(1)
    total = 0
    checking.transactions.find(:all).each do |transaction|
      total += transaction.real_amount
    end
    assert_equal total, checking.total
  end
end
