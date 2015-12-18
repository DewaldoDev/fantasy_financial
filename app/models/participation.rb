class Participation < ActiveRecord::Base
	belongs_to :user
	belongs_to :group
	after_save :assign_portfolios

	def assign_portfolios
		self.user.portfolios.create(
				group_id: self.group.id,
				current_value: self.group.starting_total,
				cash: self.group.starting_total)
	end
end