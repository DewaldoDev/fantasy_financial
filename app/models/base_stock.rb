class BaseStock < ActiveRecord::Base
	require 'yahoo_finance'

	has_many :owned_stocks

	def self.seed_stocks
		tickers = []
		text = File.open('./lib/tickers20.txt').read
		text.gsub!(/\r\n?/, "\n")

		text.each_line {|line| tickers << line.chomp}

		stocks = YahooFinance::Stock.new(tickers, [:name, :last_trade_price_only, :bid]).fetch

		stocks.each do |ticker, info|
			BaseStock.create(
				ticker: ticker,
				name: info[:name],
				current_market_price: info[:last_trade_price_only].to_f,
				current_bid_price: info[:bid].to_f)
		end
	end

	def self.update_prices
		tickers = BaseStock.all.map{:ticker}
	end
end
