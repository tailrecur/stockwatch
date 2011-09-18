require 'managers/manager'
require 'formulae/formula'

class Deepak < Manager

  def initialize
    super()
    @formulae << Formula.new(:eps, "company.eps > sector.eps", 2)
    @formulae << Formula.new(:pe_ratio, "company.pe_ratio < sector.pe_ratio", 2)
    @formulae << Formula.new(:ronw, "company.ronw > sector.ronw", 2)
    @formulae << Formula.new(:price_to_book_value_multiple, "company.price_to_book_value_multiple < sector.price_to_book_value_multiple", 2)

    @formulae << Formula.new(:latest_quarter_net_profit, "company.latest_quarter_net_profit > 0 && (company.latest_quarter_net_profit > (company.previous_quarter_net_profit * 1.25))", 2)
    @formulae << Formula.new(:latest_quarter_net_profit, "company.latest_quarter_net_profit < company.previous_quarter_net_profit", -1)
    @formulae << Formula.new(:previous_quarter_net_profit, "company.latest_quarter_net_profit < 0 && company.previous_quarter_net_profit < 0", -2)
    @formulae << Formula.new(:latest_quarter_net_profit, "company.latest_quarter_net_profit < 0", -2)
    @formulae << Formula.new(:last_FY_net_profit, "company.last_FY_net_profit < 0", -1)
    
    @formulae << Formula.new(nil, "((company.previous_quarter_net_profit + company.latest_quarter_net_profit) * 2) >  company.last_FY_net_profit", 1)
    @formulae << Formula.new(nil, "((company.previous_quarter_net_profit + company.latest_quarter_net_profit) * 2) >  company.last_FY_net_profit * 1.25", 1)
    @formulae << Formula.new(nil, "((company.previous_quarter_net_profit + company.latest_quarter_net_profit) * 2) <=  company.last_FY_net_profit", -1)

    @formulae << Formula.new(:year_high, "company.latest_price > (0.9 * company.year_high)", 2)
    @formulae << Formula.new(:year_low, "company.latest_price < (company.year_low + (company.year_high - company.year_low)*0.5)", -2)
  end
end

