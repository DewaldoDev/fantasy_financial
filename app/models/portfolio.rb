class Portfolio < ActiveRecord::Base
	belongs_to :group
	belongs_to :user
	has_many :owned_stocks

	validates :group_id, :user_id, presence: true
end
