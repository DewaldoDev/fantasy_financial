class Portfolio < ActiveRecord::Base
	belongs_to :group
	belongs_to :user
	has_many :owned_stocks

	validates :group_id, :user_id, presence: true

	def calculate_value
		self.current_value = self.stocks_value + self.cash
		self.save
	end

	def stocks_value
		self.owned_stocks.inject{|sum, stock| sum += stock.current_market_value}
	end
end
