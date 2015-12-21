class BaseStock < ActiveRecord::Base
	require 'yahoo_finance'

	has_many :owned_stocks

	validates :current_market_price, numericality: {greater_than: 0}

	def self.seed_stocks_from_file(filename)

		tickers = read_tickers_from_file(filename)

		stocks = fetch_stock_data(tickers, [:name, :last_trade_price_only, :change, :change_in_percent, :industry, :sector])

		puts "Stock data fetched"

		stocks.each do |ticker, info|
			puts "Creating stock #{ticker}"
			BaseStock.create(
				ticker: ticker,
				name: info[:name],
				current_market_price: info[:last_trade_price_only].to_f,
				change: info[:change].to_f,
				percent_change: info[:change_in_percent].to_f,
				industry: info[:industry]||"N/A",
				sector: info[:sector]||"N/A")
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
		stock_data = {}
		tickers.each_slice(300) do |ticker_chunk|
			puts "Processing ticker chunk"
			stock_data.merge!(YahooFinance::Stock.new(ticker_chunk, options).fetch)
		end
		stock_data
	end

	def self.update_prices
		stocks = BaseStock.all
		data = fetch_stock_data(stocks.map(&:ticker), [:last_trade_price_only, :change, :change_in_percent])

		stocks.each do |stock|
			t = stock.ticker
			stock.current_market_price = data[t][:last_trade_price_only]
			stock.change = data[t][:change]
			stock.percent_change = data[t][:change_in_percent]
			stock.save
		end
	end

	private_class_method :read_tickers_from_file, :fetch_stock_data

end
