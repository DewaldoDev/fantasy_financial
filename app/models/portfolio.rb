class Portfolio < ActiveRecord::Base
	belongs_to :group
	belongs_to :user
	has_many :owned_stocks

	validates :group_id, :user_id, :cash, presence: true
	validates :cash, numericality: {greater_than: 0}


	def name
		self.group.name
	end

	def calculate_value
		if self.owned_stocks.present?
			self.current_value = self.stocks_value + self.cash
			self.save
		else
			self.current_value = self.cash
			self.save
		end
	end

	def stocks_value
		total_value = 0
		self.owned_stocks.each do |stock|
			total_value += stock.quantity * stock.current_market_price
		end
		total_value
	end
end
