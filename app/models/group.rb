class Group < ActiveRecord::Base
	has_many :participations
	has_many :users, through: :participations
	has_many :portfolios

	validates :name, :end_date, :starting_total, :max_size, presence: true
	validates :starting_total, :max_size, numericality: {greater_than: 0}
	validates_datetime :end_date, after: :start_date

	before_validation :set_start_date, on: [:create]
	after_create :assign_portfolios

	def set_start_date
		self.start_date = Time.now
	end

	def assign_portfolios
		self.users.each do |user|
			user.portfolios.create(
				group_id: self.id,
				current_value: 0,
				cash: self.starting_total)
		end
	end
end
