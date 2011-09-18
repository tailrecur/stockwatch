require File.dirname(__FILE__) + '/../test_helper'

require 'formulae/pe_ratio_formula'

class PeRatioFormulaTest < Test::Unit::TestCase
  fixtures(:sectors)
  
  def test_evaluate_company
    tech_sector = sectors(:tech_sector)
    company = tech_sector.companies[0] 
    company.pe_ratio = tech_sector.pe_ratio - 1  
    PeRatioFormula.new.evaluate_company(tech_sector)    
    assert company.is_marked(:pe_ratio)
  end
end
