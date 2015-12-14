class BaseStock < ActiveRecord::Base
	require 'yahoo_finance'

	has_many :owned_stocks

	validates :current_market_price, :current_bid_price, numericality: {greater_than: 0}

	def self.seed_stocks_from_file(filename)

		tickers = read_tickers_from_file(filename)

		stocks = fetch_stock_data(tickers, [:name, :last_trade_price_only, :bid])

		stocks.each do |ticker, info|
			BaseStock.create(
				ticker: ticker,
				name: info[:name],
				current_market_price: info[:last_trade_price_only].to_f,
				current_bid_price: info[:bid].to_f)
		end
	end

	def self.read_tickers_from_file(filename)
		tickers = []
		text = File.open(filename).read
		text.gsub!(/\r\n?/, "\n")

		text.each_line {|line| tickers << line.chomp}
		tickers
	end

	def self.fetch_stock_data(tickers, options)
		YahooFinance::Stock.new(tickers, options).fetch
	end

	def self.update_prices
		stocks = BaseStock.all
		data = fetch_stock_data(stocks.map(&:ticker), [:last_trade_price_only, :bid])

		stocks.each do |stock|
			t = stock.ticker
			stock.current_market_price = data[t][:last_trade_price_only]
			stock.current_bid_price = data[t][:bid]
			stock.save
		end
	end

	private_class_method :read_tickers_from_file, :fetch_stock_data

end
