class User < ActiveRecord::Base
	authenticates_with_sorcery!

	has_many :logs
  has_many :participations
	has_many :portfolios
	has_many :groups, through: :participations

	validates :email, :username, presence: true
	validates :email, :username, uniqueness: true

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes["password"] }
  validates :password, confirmation: true, if: -> { new_record? || changes["password"] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes["password"] }

  def stock_count(stock)
  	stock_info = {}
  	self.portfolios.each do |portfolio|
  		group_name = portfolio.group.name
  		stock = portfolio.owned_stocks.where(ticker: stock.ticker) if portfolio.owned_stocks.present?
  		count = stock.quantity if stock.present?

  		stock_info[group_name.parameterize.underscore.to_sym] = count if count.present?
  	end
  	stock_info
  end

  def find_portfolio(group_id)
    self.portfolios.find_by(group_id: group_id)
  end

end
