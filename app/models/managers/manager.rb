class Manager
    def initialize
        @formulae = []
    end

    def evaluate_stocks(sectors)
        sectors.each do |sector|
            sector.companies.each do |company|
                @formulae.each do |formula|
                    if formula.evaluate_company(company, sector)
                        rating = formula.weightage > 0 ? "good" :"bad"
                        company.rate_field(formula.field, rating)
                        company.add_score(formula.weightage)
                    end
                end
            end
        end
    end
end
