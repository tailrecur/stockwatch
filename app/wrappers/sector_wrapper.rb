require 'wrappers/company_wrapper'

class SectorWrapper
    attr_reader :companies
    attr_accessor :score

    def self.wrap_sectors sectors
        wrapped_sectors = []
        sectors.each do |sector|
            wrapped_sectors << SectorWrapper.new(sector)
        end
        return wrapped_sectors
    end

    def initialize sector
        @sector = sector
        @companies = CompanyWrapper.wrap_companies(sector.companies)
        @score = 0
    end

    def method_missing(method, *args)
        @sector.send(method, *args)    
    end
end