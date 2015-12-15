module DateHelper

	def current_date
		Time.now
	end

	def print_date(date=Time.now)
		date.strftime("%A %B %e, %Y at %H:%M")
	end
end