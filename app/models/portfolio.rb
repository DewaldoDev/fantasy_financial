class Portfolio < ActiveRecord::Base
	# needed to use number_to_currency
	include ActionView::Helpers::NumberHelper
	belongs_to :group
	belongs_to :user
	has_many :owned_stocks

	validates :group_id, :user_id, :cash, presence: true
	validates :cash, numericality: {greater_than: 0}


	def name
		self.group.name
	end

	def calculate_equity
		equity = 0
		self.owned_stocks.each do |stock|
      equity += stock.total_value
    end
    equity
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

	def buy_display
		display_cash = number_to_currency(cash)
		"#{name} | Cash Remaining #{display_cash}"
	end
end
