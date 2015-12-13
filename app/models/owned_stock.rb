class OwnedStock < ActiveRecord::Base
	include Stock

	belongs_to :portfolio
end
