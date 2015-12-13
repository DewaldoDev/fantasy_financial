class Portfolio < ActiveRecord::Base
	belongs_to :group
	has_many :stocks
end
