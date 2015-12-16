class OwnedStock < ActiveRecord::Base
	belongs_to :portfolio
	belongs_to :base_stock

	validate :must_have_sufficient_cash
	validates :buy_price, :quantity, :buy_date, :portfolio_id, :base_stock_id, presence: true
	validates :buy_price, :quantity, numericality: {greater_than: 0}

	before_validation :set_buy_date, on: [:create]


	def must_have_sufficient_cash
		total_cost = self.quantity * self.buy_price
		if portfolio.cash < total_cost
			errors.add(:quantity, "Insufficient cash for stock purchase")
		end
	end

	def set_buy_date
		self.buy_date = Time.now
	end

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
