require File.dirname(__FILE__) + '/../test_helper'

require 'formulae/eps_formula'

class EpsFormulaTest < Test::Unit::TestCase
  fixtures(:sectors)
  
  def test_evaluate_company
    tech_sector = sectors(:tech_sector)
    company = tech_sector.companies[0] 
    company.eps = tech_sector.eps + 1  
    EpsFormula.new.evaluate_company(tech_sector)    
    assert company.is_marked(:eps)
  end
end
