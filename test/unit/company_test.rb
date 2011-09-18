require File.dirname(__FILE__) + '/../test_helper'

class CompanyTest < Test::Unit::TestCase
    fixtures :companies

  def test_invalid_if_empty_attributes
    company = Company.new
    assert !company.valid?
    assert company.errors.invalid?(:name)
    assert company.errors.invalid?(:latest_price)
  end
  
  def test_name_has_to_be_unique
    sector = Company.new(:name => companies(:thoughtworks).name, :latest_price => 12.45)
    assert !sector.valid?    
    assert_equal ActiveRecord::Errors.default_error_messages[:taken], sector.errors.on(:name)
  end
  
  def test_marking_field
    company = companies(:thoughtworks)
    assert !company.is_marked(:eps)
    company.mark_field(:eps)
    assert company.is_marked(:eps)
  end
end
