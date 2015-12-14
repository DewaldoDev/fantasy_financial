class OwnedStock < ActiveRecord::Base
	belongs_to :portfolio
	belongs_to :base_stock

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
