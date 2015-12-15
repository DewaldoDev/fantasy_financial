class Group < ActiveRecord::Base
	has_many :participations
	has_many :users, through: :participations
	has_many :portfolios

	validates :name, :end_date, :starting_total, :max_size, presence: true
	validates :name, uniqueness: true
	validates :starting_total, :max_size, numericality: {greater_than: 0}
	validates_datetime :end_date, after: :start_date
end
