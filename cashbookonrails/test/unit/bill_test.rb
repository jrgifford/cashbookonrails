require File.dirname(__FILE__) + '/../test_helper'

class BillTest < ActiveSupport::TestCase
  def setup
    bill_default_values = {
            :payee_id => 1,
            :account_id => 1,
            :next_payment_date => 2.days.ago,
            :payment_method => "cs",
            :frequency => "dy",
            :amount => 345.89,
            :category_id => 1
            }
    @bill = Bill.new(bill_default_values)
  end

  def test_create_valid_record
    assert @bill.valid?, "Bill is invalid:\n#{@bill.to_yaml}"
  end

  def test_cant_create_without_obrigatory_fields
    @bill.payee_id = @bill.account_id = @bill.next_payment_date = @bill.payment_method = @bill.frequency = @bill.amount = ""
    assert (not @bill.valid?)
    assert_not_nil @bill.errors.on(:payee_id)
    assert_not_nil @bill.errors.on(:account_id)
    assert_not_nil @bill.errors.on(:next_payment_date)
    assert_not_nil @bill.errors.on(:payment_method)
    assert_not_nil @bill.errors.on(:frequency)
    assert_not_nil @bill.errors.on(:amount)
  end

  def test_amount_must_validates_precision
    @bill.amount = "88.00"
    assert @bill.valid?, "88.00 should be valid!"
    assert_nil @bill.errors.on(:amount)

    @bill.amount = "88.80"
    assert @bill.valid?, "88.80 should be valid!"
    assert_nil @bill.errors.on(:amount)

    @bill.amount = "88.88"
    assert @bill.valid?, "88.88 should be valid!"
    assert_nil @bill.errors.on(:amount)

    @bill.amount = "88.888"
    assert (not @bill.valid?), "88.888 should be invalid!"
    assert_not_nil @bill.errors.on(:amount)
  end

  def test_amount_cant_be_negative_or_zero
    @bill.amount = "-88.80"
    assert (not @bill.valid?)
    assert_not_nil @bill.errors.on(:amount)

    @bill.amount = "0.00"
    assert (not @bill.valid?)
    assert_not_nil @bill.errors.on(:amount)

    @bill.amount = "88.80"
    assert @bill.valid?
    assert_nil @bill.errors.on(:amount)
  end

  def test_real_amount_must_show_negative_if_a_debit
    @bill.amount = "88.80"
    @bill.category = Category.find(2)
    assert_equal @bill.real_amount, -88.80
  end

  def test_bill_payment
    @bill.payee = Payee.find(1)
    @bill.pay
    transaction = Transaction.find(:all, :conditions => {:number => @bill.number})
    assert_not_nil transaction
  end

end
