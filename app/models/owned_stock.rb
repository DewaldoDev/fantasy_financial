class OwnedStock < ActiveRecord::Base
	belongs_to :portfolio
	belongs_to :base_stock

	validates :buy_price, :quantity, :buy_date, :portfolio_id, :base_stock_id, presence: true
	validates :buy_price, :quantity, numericality: {greater_than: 0}
	validate :must_have_sufficient_cash

	before_validation :set_properties, on: [:create]

	after_save :update_portfolio

	def must_have_sufficient_cash
		total_cost = self.quantity * self.buy_price
		if portfolio.cash < total_cost
			errors.add(:quantity, "Insufficient cash for stock purchase")
		end
	end

	def set_properties
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

	def update_portfolio
		self.portfolio.cash -= self.current_market_price * self.quantity
		self.portfolio.calculate_value
	end

	def total_value
		self.current_market_price * self.quantity
	end

end
