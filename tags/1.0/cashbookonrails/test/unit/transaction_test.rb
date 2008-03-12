require File.dirname(__FILE__) + '/../test_helper'

class TransactionTest < ActiveSupport::TestCase
  def setup
    transaction_default_values = {
            :date => 3.days.ago,
            :number => "1",
            :payee_category => "River Shopping",
            :amount => 120.87,
            :account_id => 1
            }
    @transaction = Transaction.new(transaction_default_values)
  end

  def test_create_valid_record
    assert @transaction.valid?, "Transaction is invalid:\n#{@transaction.to_yaml}"
  end

  def test_cant_create_without_obrigatory_fields
    @transaction.amount = ""
    assert (not @transaction.valid?)
    assert_not_nil @transaction.errors.on(:amount)
  end

  def test_amount_must_validates_precision
    @transaction.amount = "88.00"
    assert @transaction.valid?, "88.00 should be valid!"
    assert_nil @transaction.errors.on(:amount)

    @transaction.amount = "88.80"
    assert @transaction.valid?, "88.80 should be valid!"
    assert_nil @transaction.errors.on(:amount)

    @transaction.amount = "88.88"
    assert @transaction.valid?, "88.88 should be valid!"
    assert_nil @transaction.errors.on(:amount)

    @transaction.amount = "88.888"
    assert (not @transaction.valid?), "88.888 should be invalid!"
    assert_not_nil @transaction.errors.on(:amount)
  end

  def test_amount_cant_be_negative_or_zero
    @transaction.amount = "-88.80"
    assert (not @transaction.valid?)
    assert_not_nil @transaction.errors.on(:amount)

    @transaction.amount = "0.00"
    assert (not @transaction.valid?)
    assert_not_nil @transaction.errors.on(:amount)

    @transaction.amount = "88.80"
    assert @transaction.valid?
    assert_nil @transaction.errors.on(:amount)
  end

  def test_real_amount_must_show_negative_if_a_debit
    @transaction.amount = "88.80"
    @transaction.credit = false
    assert_equal @transaction.real_amount, -88.80
  end

  def test_transaction_belong_to_account
    assert_not_nil @transaction.account
    assert_not_nil @transaction.account.name
  end
end
