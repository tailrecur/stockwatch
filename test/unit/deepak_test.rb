require File.dirname(__FILE__) + '/../test_helper'
require 'managers/deepak'

class DeepakTest < Test::Unit::TestCase
  fixtures(:sectors)
  
  def test_evaluate_stocks
    sectors = Sector.find(:all)
    sector = sectors[0]
    company = sector.companies[0]
    company.eps = sector.eps + 1
    company.pe_ratio = sector.pe_ratio - 1
    company.ronw = sector.ronw + 1
    company.price_to_book_value_multiple = sector.price_to_book_value_multiple - 1
    
    company.latest_quarter_net_profit = company.previous_quarter_net_profit * 1.3
    company.latest_price = company.year_low + 1
    
    
    manager = Deepak.new
    manager.evaluate_stocks  sectors
    assert company.is_marked(:eps)
    assert company.is_marked(:pe_ratio)
    assert company.is_marked(:ronw)
    assert company.is_marked(:price_to_book_value_multiple)
    assert company.is_marked(:latest_quarter_net_profit)
    assert company.is_marked(:year_low)
  end
end
