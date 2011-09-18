require 'managers/deepak'
require 'managers/icici_direct'
require 'wrappers/sector_wrapper'

class StockwatchController < ApplicationController

    def index
        @sectors = session[:sectors]
        if @sectors.nil?
            @sectors = Sector.find(:all)
            session[:sectors] = @sectors
        end
#        Util.calculate_averages @sectors
        
        @sectors = SectorWrapper.wrap_sectors(@sectors)
        managers = []
        managers << Deepak.new
        managers << IciciDirect.new

        managers.each do |manager|
            manager.evaluate_stocks @sectors
        end
        Util.sort_by_score @sectors
    end

    def refresh_data
        uri = URI::parse("http://content.icicidirect.com/research/sectorwatch.asp")
        #            uri = URI::parse("file://C:/workspace/stockwatch/public/mock/sectorwatch.htm")
        sectors = StockLoader.load uri
        Util.calculate_averages(sectors)
        session[:sectors] = sectors
        redirect_to(:action =>'index')
    end

end
