class CompanyWrapper
  attr_accessor :score
  
  def self.wrap_companies(companies)
    wrapped_companies = []
    companies.each do |company|
      wrapped_companies << CompanyWrapper.new(company)
    end
    return wrapped_companies
  end

  def initialize company
    @company = company
    @score = 0
    @rated_fields = {}
  end
    
  def rate_field(field, rating)
    @rated_fields = {} if @rated_fields.nil?
    @rated_fields[field] = rating
  end
  
  def is_rated field
    !@rated_fields.nil? && !@rated_fields[field].nil?
  end

  def get_rating field                               
    @rated_fields[field] if !@rated_fields.nil?
  end
  
  def add_score value
    @score = 0 if @score.nil?
    @score += value
  end

  def method_missing(method, *args)
    @company.send(method, *args)
  end
end