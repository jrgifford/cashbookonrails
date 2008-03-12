require File.dirname(__FILE__) + '/../test_helper'

class CategoryTest < ActiveSupport::TestCase
  def setup
    category_default_values = {
            :name => "Education",
            :credit => true
            }
    @category = Category.new(category_default_values)
  end

  def test_create_valid_record
    assert @category.valid?, "Category is invalid:\n#{@category.to_yaml}"
  end

  def test_cant_create_without_obrigatory_fields
    @category.name = ""
    assert (not @category.valid?)
    assert_not_nil @category.errors.on(:name)    
  end
end
