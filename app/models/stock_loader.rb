require 'net/http'
require 'hpricot'

class StockLoader
  attr_reader :sectors

  def self.load uri
    @loader = StockLoader.new(uri) if @loader.nil?
    Sector.transaction do
      @loader.empty_tables
      @loader.read_sectors
      @loader.fetch_companies uri
    end
    return @loader.sectors
  end

  def initialize uri
    @sectors_table = Hpricot(uri.open).search "html/body/table/tr/td/table"
  end

  def empty_tables
    Company.delete_all
    Sector.delete_all
  end

  def read_sectors
    @sectors = []
    (@sectors_table.search "tr").each do |sector_row|
      if sector_row.inner_html.include?("<td bgcolor=\"#eb922c\" valign=\"top\" align=\"center\"")
        @sectors << Sector.create(
          :name => sector_row.search("td/font/strong/").to_s,
          :outlook => sector_row.search("td/strong/a/font/b/").to_s,
          :child_url => sector_row.search("td/strong").inner_html.sub(/^.*href=\"/, "").sub(/\".*$/, ""),
          :companies => []
        )
      end
    end
  end

  def fetch_companies uri
    @sectors.each do |sector|
      uri.set_path(sector.child_url)
      Hpricot(uri.open).search("html/body/table/tr/td/table").each do |company_table|
        if company_table.inner_html.include?("companysnapshot.asp?icicicode=")
          read_companies sector, company_table
        end
      end
    end
  end

  def read_companies sector, company_table
    company_table.search("tr").each do |company_row|
      if company_row.inner_html.include?("companysnapshot.asp?icicicode=")
        company_details = company_row.search("td")
        book_value = retrieve_decimal(company_details[6])
        latest_price = retrieve_decimal(company_details[12])
        sector.companies << Company.create(
          :name => company_details[0].search("a/b/font/").to_s.strip,
          :last_FY_net_profit => retrieve_decimal(company_details[1]),
          :previous_quarter_net_profit => retrieve_decimal(company_details[2]),
          :latest_quarter_net_profit => retrieve_decimal(company_details[3]),
          :eps => retrieve_decimal(company_details[4]),
          :pe_ratio => retrieve_decimal(company_details[5]),
          :book_value => book_value,
          :ronw => retrieve_decimal(company_details[7]),
          :market_cap => retrieve_decimal(company_details[8]),
          :dividend_per_share => retrieve_decimal(company_details[9]),
          :year_high => retrieve_decimal(company_details[10]),
          :year_low => retrieve_decimal(company_details[11]),
          :latest_price => latest_price,
          :rating => company_details[13].search("b/font/").to_s.strip,
          :sector_id => sector.id,
          :price_to_book_value_multiple => latest_price/book_value
        )
      end
    end
  end

  def retrieve_decimal element
    element.search("font/").to_s.gsub(/&nbsp;/, "").to_f
  end
end

class URI::Generic
  def set_path path
    if (self.is_a?(URI::HTTP))
      @path = "/research/"+path
    else
      @path = path
    end
  end

  def open
    if (self.is_a?(URI::HTTP))
      resource = Net::HTTP.new(host, port)
      headers, data = resource.get(path)
    else
      data = ""
      File.open(host+":"+path) do |infile|
        while (line = infile.gets)
          data << line
        end
      end
    end
    return data
  end
end