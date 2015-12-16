class Portfolio < ActiveRecord::Base
	belongs_to :group
	belongs_to :user
	has_many :owned_stocks

	validates :group_id, :user_id, :cash, presence: true
	validates :cash, numericality: {greater_than: 0}

	after_update :calculate_value

	def calculate_value
		if self.owned_stocks.present? && self.owned_stocks_changed?
			self.current_value = self.stocks_value + self.cash
			self.save
		else
			self.current_value = self.cash
			self.save
		end
	end

	def stocks_value
		self.owned_stocks.inject{|sum, stock| sum += stock.current_market_value}
	end
end
