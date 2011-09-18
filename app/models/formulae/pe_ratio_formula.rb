class EpsFormula 
  def evaluate_company(sector)  
    sector.companies.each do |company|
      company.mark_figure(:eps) if(company.eps > sector.eps)
    end
  end
end
