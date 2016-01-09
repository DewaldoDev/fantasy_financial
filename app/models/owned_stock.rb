class OwnedStock < ActiveRecord::Base
	belongs_to :portfolio
	belongs_to :base_stock

	validates :buy_price, :quantity, :buy_date, :portfolio_id, :base_stock_id, presence: true
	validates :buy_price, :quantity, numericality: {greater_than: 0}
	validate :must_have_sufficient_cash

	before_validation :set_properties, on: [:create]
	after_save :update_portfolio

	delegate :ticker, :name, :current_market_price, :change, :percent_change, :industry, :sector, to: :base_stock

	def must_have_sufficient_cash
		total_cost = (self.quantity.to_f||0.0) * self.buy_price
		if portfolio.cash < total_cost
			errors.add(:quantity, "Insufficient cash for stock purchase")
		end
	end

	def sell_stock(quantity_to_sell)
		if quantity_to_sell <= 0 || self.quantity < quantity_to_sell
				flash[:warning] = "Cannot purchase stocks at this amount"
		else
			return_amount = (quantity_to_sell * self.current_market_price).round(2)
			self.quantity -= quantity_to_sell
			self.quantity == 0 ? self.destroy : self.save
			return return_amount
		end
	end

	def update_portfolio
		self.portfolio.cash -= (self.quantity * self.buy_price)
		self.portfolio.save
		self.portfolio.calculate_value
	end

	def total_value
		self.current_market_price * self.quantity.to_f
	end

	def set_properties
		self.buy_date = Time.now
	end

end
