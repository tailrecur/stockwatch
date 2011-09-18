class AddColumnsToCompanyTable < ActiveRecord::Migration
    def self.up
        add_column :companies, :name, :string, :null => false
        add_column :companies, :last_FY_net_profit, :decimal, :precision => 8, :scale => 2
        add_column :companies, :previous_quarter_net_profit, :decimal, :precision => 8, :scale => 2
        add_column :companies, :latest_quarter_net_profit, :decimal, :precision => 8, :scale => 2
        add_column :companies, :eps, :decimal, :precision => 8, :scale => 2
        add_column :companies, :pe_ratio, :decimal, :precision => 8, :scale => 2
        add_column :companies, :book_value, :decimal, :precision => 8, :scale => 2
        add_column :companies, :ronw, :decimal, :precision => 8, :scale => 2
        add_column :companies, :market_cap, :decimal, :precision => 8, :scale => 2
        add_column :companies, :dividend_per_share, :decimal, :precision => 8, :scale => 2
        add_column :companies, :year_high, :decimal, :precision => 8, :scale => 2
        add_column :companies, :year_low, :decimal, :precision => 8, :scale => 2
        add_column :companies, :latest_price, :decimal, :precision => 8, :scale => 2, :null => false
        add_column :companies, :price_to_book_value_multiple, :decimal, :precision => 8, :scale => 2
        add_column :companies, :rating, :string
    end

    def self.down
        remove_column :companies, :name
        remove_column :companies, :last_FY_net_profit
        remove_column :companies, :previous_quarter_net_profit
        remove_column :companies, :latest_quarter_net_profit
        remove_column :companies, :eps
        remove_column :companies, :pe_ratio
        remove_column :companies, :book_value
        remove_column :companies, :ronw
        remove_column :companies, :market_cap
        remove_column :companies, :dividend_per_share
        remove_column :companies, :year_high
        remove_column :companies, :year_low
        remove_column :companies, :latest_price
        remove_column :companies, :price_to_book_value_multiple
        remove_column :companies, :rating
    end
end
