require File.dirname(__FILE__) + '/../test_helper'

class StockLoaderTest < Test::Unit::TestCase
#    def test_fetch_companies
#        uri = URI::parse("file://C:/workspace/stockwatch/public/mock/sectorwatch.htm")
##        uri = URI::parse("http://content.icicidirect.com/research/sectorwatch.asp")
#        
#        sectors = StockLoader.load uri
#        power_sector = sectors[0]
#        assert_equal "POWER", power_sector.name
#        assert power_sector.companies.size > 0
#    end
  
  def test_loads_sectors_and_power_sector_companies
    sectors = StockLoader.load(URI::parse("file://C:/workspace/stockwatch/public/mock/sectorwatch.htm"))
    assert 16, sectors.size 
    power_sector = sectors[0]
    assert_equal "POWER", power_sector.name
    assert_equal 6, power_sector.companies.size
    assert_in_delta 9.49, power_sector.eps, 0.01
    assert_in_delta 23.69, power_sector.pe_ratio, 0.01
    assert_in_delta 7.87, power_sector.ronw, 0.01
    assert_in_delta 3.06, power_sector.price_to_book_value_multiple, 0.01
  end
end
