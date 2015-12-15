class Log < ActiveRecord::Base
		before_validation :set_trade_time, on: [:create]

	def set_trade_time
		self.trade_time = Time.now
	end
end
