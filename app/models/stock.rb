class Stock < ApplicationRecord
  has_many :user_stocks
  has_many :users, through: :user_stocks

  def self.new_from_lookup(ticker_symbol)
    looked_up_stock = StockQuote::Stock.quote(ticker_symbol)
    return if looked_up_stock.nil?
    price = strip_commas(looked_up_stock.close)
    new(name: looked_up_stock.company_name, ticker: looked_up_stock.symbol, last_price: price)
  end

  def self.find_by_ticker(ticker_symbol)
    where(ticker: ticker_symbol).first
  end

  private

  def self.strip_commas(number)
    "#{number}".gsub(",", "")
  end
end
