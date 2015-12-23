class Participation < ActiveRecord::Base
	belongs_to :user
	belongs_to :group
	after_save :assign_portfolios, on: [:create]

def assign_portfolios
	user = self.user

	unless user.portfolios.where(group_id: self.group_id).present?
		self.user.portfolios.create(
				group_id: self.group.id,
				current_value: self.group.starting_total,
				cash: self.group.starting_total)
		end
	end
end