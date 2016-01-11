class Log < ActiveRecord::Base
	belongs_to :user
	belongs_to :base_stock
	belongs_to :group

	before_validation :set_properties, on: [:create]

	def set_properties
		self.trade_time = Time.now
	end

end
