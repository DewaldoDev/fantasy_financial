class OwnedStock < ActiveRecord::Base
	belongs_to :portfolio
	belongs_to :base_stock

	# User needs to give a "ticker" parameter to the create function
	# Using the ticker, find the right BaseStock and link it with the OwnedStock

	# When you call OwnedStock.create() it only wants OwnedStock properties
	# It doesn't know what to do with a "ticker" property

	# When you call OwnedStock.create() pass in BaseStock.where(ticker: "ticker_value")
	# This will set up the association we want

	def ticker
		self.base_stock.ticker
	end

	def name
		self.base_stock.name
	end

	def current_market_price
		self.base_stock.current_market_price
	end

	def current_bid_price
		self.base_stock.current_bid_price
	end
end
