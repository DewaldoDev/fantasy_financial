class BaseStock < ActiveRecord::Base
	require 'yahoo_finance'

	has_many :owned_stocks

	def self.seed_stocks

	end

	def self.fetch_current_price

	end
end
