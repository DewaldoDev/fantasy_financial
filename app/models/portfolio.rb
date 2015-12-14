class Portfolio < ActiveRecord::Base
	belongs_to :group
	belongs_to :user
	has_many :owned_stocks
end
