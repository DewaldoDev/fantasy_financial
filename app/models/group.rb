class Group < ActiveRecord::Base
	has_many :participations
	has_many :users, through: :participations
	has_many :portfolios
	has_many :logs

	validates :name, :end_date, :starting_total, :max_size, presence: true
	validates :starting_total, :max_size, numericality: {greater_than: 0}
	validates_datetime :end_date, after: :start_date

	before_validation :set_start_date, on: [:create]

	def set_start_date
		self.start_date = Time.now
	end

	def is_full?
		self.users.size >= self.max_size
	end
end
