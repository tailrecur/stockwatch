require 'managers/manager'
require 'formulae/formula'

class IciciDirect < Manager

    def initialize
        super()
        @formulae << Formula.new(:rating, "company.rating == 'Over Weight'", 3)
        @formulae << Formula.new(:rating, "company.rating == 'Under Weight'", -1)
        @formulae << Formula.new(nil, "sector.outlook == 'Over Weight'", 3)
        @formulae << Formula.new(nil, "sector.outlook == 'Under Weight'", -1)
    end
end
