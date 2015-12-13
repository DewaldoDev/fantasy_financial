class User < ActiveRecord::Base
	has_many :participations
	has_many :groups, through: :participations
	has_many :portfolios, through: :groups
end
