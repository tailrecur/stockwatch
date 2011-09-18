require File.dirname(__FILE__) + '/../test_helper'
#require 'stock_list_helper'

class StockListHelperTest < Test::Unit::TestCase
    fixtures :sectors, :companies
    
    def test_calculate_averages
        sectors = []
        tech_sector = sectors(:tech_sector)
        tech_sector.add_company(companies(:thoughtworks))
        sectors << tech_sector
        StockListHelper.calculate_averages sectors
        assert_equal 2, sectors[0].average_eps
    end
end
