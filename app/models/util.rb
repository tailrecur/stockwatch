class Util
    def self.calculate_averages sectors
        Sector.transaction do
            sectors.each do |sector|
                sector.eps = get_average_for(:eps, sector)
                sector.pe_ratio = get_average_for(:pe_ratio, sector)
                sector.ronw = get_average_for(:ronw, sector)
                sector.price_to_book_value_multiple = get_average_for(:price_to_book_value_multiple, sector)
                sector.save
            end
        end
    end

    def self.get_average_for(field, sector)
        array = sector.companies.collect do |company|
            company.send(field)
        end
        min = array.min
        max = array.max
        weighted_array = array.find_all do |value|
            value != min && value != max
        end
        weighted_array.sum / weighted_array.size
    end

    def self.sort_by_score sectors
        sectors.each do |sector|
            company_scores = sector.companies.collect do |company|
                company.score
            end
            company_scores.compact!
            sector.score = company_scores.sum / sector.companies.size
            sector.companies.sort! do |a, b|
                b.score.nil? ? -1: (a.score.nil? ? 1: (b.score - a.score))
                #                b.score <=> a.score
            end
        end
        sectors.sort! do |a, b|
            #            b.score <=> a.score
            b.score.nil? ? -1: (a.score.nil? ? 1: (b.score - a.score))
        end
    end
end