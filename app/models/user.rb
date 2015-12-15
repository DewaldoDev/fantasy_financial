class User < ActiveRecord::Base
	authenticates_with_sorcery!

	has_many :participations
	has_many :portfolios
	has_many :groups, through: :participations

	validates :email, :username, presence: true
	validates :email, :username, uniqueness: true

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes["password"] }
  validates :password, confirmation: true, if: -> { new_record? || changes["password"] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes["password"] }

end