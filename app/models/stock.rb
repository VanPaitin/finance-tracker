class Stock < ApplicationRecord
  def self.new_from_lookup(ticker_symbol)
    looked_up_stock = StockQuote::Stock.quote(ticker_symbol)
    return if looked_up_stock.nil?
    price = strip_commas(looked_up_stock.close)
    new(name: looked_up_stock.company_name, ticker: looked_up_stock.symbol, last_price: price)
  end

  def self.strip_commas(number)
    "#{number}".gsub(",", "")
  end
end
