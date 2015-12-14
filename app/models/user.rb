class User < ActiveRecord::Base
	has_many :participations
	has_many :portfolios
	has_many :groups, through: :participations

	validates :email, :username, presence: true
	validates :email, :username, uniqueness: true
end
