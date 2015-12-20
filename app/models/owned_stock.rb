class OwnedStock < ActiveRecord::Base
	belongs_to :portfolio
	belongs_to :base_stock

	validates :buy_price, :quantity, :buy_date, :portfolio_id, :base_stock_id, presence: true
	validates :buy_price, :quantity, numericality: {greater_than: 0}
	validate :must_have_sufficient_cash

	before_validation :set_properties, on: [:create]
	after_save :update_portfolio

	delegate :ticker, :name, :current_market_price, :current_bid_price, to: :base_stock

	def must_have_sufficient_cash
		total_cost = self.quantity||0 * self.buy_price
		if portfolio.cash < total_cost
			errors.add(:quantity, "Insufficient cash for stock purchase")
		end
	end

	def sell_stock(quantity_to_sell)
		if self.quantity < quantity_to_sell
			flash[:warning] = "You cannot sell more than you own"
		else
			self.quantity -= quantity_to_sell
			if self.quantity == 0
				self.destroy
			else
				self.save
			end
			return (quantity_to_sell * self.current_market_price).round(2)
		end
	end

	def update_portfolio
		self.portfolio.cash -= self.current_market_price * self.quantity
		self.portfolio.calculate_value
	end

	def total_value
		self.current_market_price * self.quantity
	end

	def set_properties
		self.buy_date = Time.now
	end

end
