module StockwatchHelper

    def apply_rating(company, figure)
        if company.is_rated(figure)
            "class='"+company.get_rating(figure)+"'"
        end
    end


end
