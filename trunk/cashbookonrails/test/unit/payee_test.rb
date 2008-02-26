require File.dirname(__FILE__) + '/../test_helper'

class PayeeTest < ActiveSupport::TestCase
  def setup        
    payee_default_values = {
            :id => 1,
            :name => "Dan Brown",
            :phone_number => "87 3861 7966"
            }
    @payee = Payee.new(payee_default_values)
  end

  def test_create_valid_record
    assert @payee.valid?, "Payee is invalid:\n#{@payee.to_yaml}"
  end

  def test_cant_create_without_obrigatory_fields
    @payee.name = @payee.phone_number = ""
    assert (not @payee.valid?)
    assert_not_nil @payee.errors.on(:name)
  end
end
