require File.dirname(__FILE__) + '/../test_helper'
require 'hpricot'

class SectorTest < Test::Unit::TestCase
  fixtures :sectors

  def test_invalid_if_empty_attributes
    sector = Sector.new
    assert !sector.valid?
    assert sector.errors.invalid?(:name)
    assert sector.errors.invalid?(:outlook)
    assert sector.errors.invalid?(:child_url)
  end

  def test_name_has_to_be_unique
    sector = Sector.new(:name => sectors(:tech_sector).name, :outlook => "good", :child_url => "url1")
    assert !sector.valid?
    assert_equal ActiveRecord::Errors.default_error_messages[:taken], sector.errors.on(:name)
  end
end
  