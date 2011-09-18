class Formula
  attr_reader :weightage, :field
  def initialize(field, condition, weightage)
    @field = field
    @condition = condition
    @weightage = weightage
  end
  
  def evaluate_company(company,sector)  
    eval(@condition)
  end
end
