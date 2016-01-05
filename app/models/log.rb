class Log < ActiveRecord::Base
	belongs_to :user

	before_validation :set_properties, on: [:create]

	def set_properties
		self.trade_time = Time.now
	end

end
